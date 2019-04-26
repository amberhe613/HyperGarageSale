import 'dart:io';

import 'package:flutter/material.dart';
import 'package:winter2019/models/post_model.dart';
import 'post_photo_using_camera.dart';
import 'borwse_posts_activity.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class NewPostActivity extends StatelessWidget {
  final Post post;

  const NewPostActivity({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BrowsePostsActivity()),
              );
            },
          ),
          title: Text('Hyper Garage Sale'),
        ),
        // body is the majority of the screen.
        body: NewPostBody(post: this.post));
  }
}

class NewPostBody extends StatefulWidget {
  final Post post;

  const NewPostBody({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  _NewPostState createState() => new _NewPostState();
}

class _NewPostState extends State<NewPostBody> {
  Post curPost;
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    curPost = widget.post;
    nameController = new TextEditingController();
    priceController = new TextEditingController();
    descriptionController = new TextEditingController();

    if (curPost == null) {
      curPost = new Post();
    } else {
      nameController.text = curPost.title;
      priceController.text = curPost.price.toString();
      descriptionController.text = curPost.description;
    }
  }

  Widget _buildProductItem(List<String> curImagePaths) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < curImagePaths.length; i++) {
      list.add(new Container(
          height: 100.0,
          width: 100.0,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: new Image.file(File(curImagePaths[i]))));
    }
    return new ListView(scrollDirection: Axis.horizontal, children: list);
  }

  Widget _cameraButton(int curImageNum, BuildContext context) {
    if (curImageNum < 4) {
      return new Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              left: BorderSide(width: 1.0, color: Colors.grey),
              right: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.blue),
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  priceController.text.isEmpty ||
                  descriptionController.text.isEmpty) {
                _infoNotCompleted(context);
              } else {
                // Obtain a list of the available cameras on the device.
                final cameras = await availableCameras();
                // Get a specific camera from the list of available cameras
                final firstCamera = cameras.first;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                            camera: firstCamera,
                            post: _getCurPostContent(context))));
              }
            },
          ));
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.grey),
              left: BorderSide(width: 1.0, color: Colors.grey),
              right: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
          child: IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.grey),
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                  new SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: new Text('You can only add up to four photos!'),
                  ),
                );
              }));
    }
  }

  void _infoNotCompleted(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        backgroundColor: Colors.redAccent,
        content: new Text('Item information is not complete!'),
      ),
    );
  }

  void _createNewPost(context) async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        curPost.imageUrls.length == 0) {
      _infoNotCompleted(context);
    } else {
      _getCurPostContent(context);
      _uploadAllImage(context);
      Firestore.instance.collection('posts').add(curPost.toMap());
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text('A new item has been added!'),
      ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BrowsePostsActivity()),
      );
    }
  }

  void _uploadAllImage(context) async {
    for (int i = 0; i < curPost.imagePaths.length; i++) {
      File image = File(curPost.imagePaths[i]);
      await _uploadImage(image, basename(image.path));
    }
  }

  Future<String> _uploadImage(File image, String filename) async {
    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(image);
    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    print("Download URL: $url");
    curPost.imageUrls.add(url);
    return url;
  }

  Post _getCurPostContent(context) {
    Post newCurPost = curPost;
    newCurPost.title = nameController.text;
    newCurPost.price = double.parse(priceController.text);
    newCurPost.description = descriptionController.text;
    newCurPost.imagePaths = curPost.imagePaths;
    curPost = newCurPost;
    return curPost;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(children: <Widget>[
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(hintText: 'Enter title of the item'),
        ),
        TextFormField(
          controller: priceController,
          decoration: InputDecoration(hintText: 'Enter price'),
        ),
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: 'Enter description of the item',
            contentPadding: const EdgeInsets.only(top: 10.0, bottom: 180.0),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: 100.0,
            child: Row(children: <Widget>[
              _cameraButton(curPost.imagePaths.length, context),
              Expanded(child: _buildProductItem(curPost.imagePaths)),
            ])),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(children: <Widget>[
              Container(width: 10.0),
              Expanded(child: Text('')),
              RaisedButton(
                  textColor: Colors.white,
                  color: Colors.amber,
                  onPressed: () => _uploadAllImage(context), child: Text('UPLOAD')),
              RaisedButton(
                  onPressed: () => _createNewPost(context), child: Text('POST'))
            ])),
      ]),
    );
  }
}