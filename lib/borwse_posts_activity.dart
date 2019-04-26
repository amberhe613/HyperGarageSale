import 'package:flutter/material.dart';
import 'new_post_activity.dart';
import 'post_list.dart';
import 'models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BrowsePostsActivity extends StatelessWidget {

  Widget _buildPostList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Post> posts = List();
    for (int i = 0; i < snapshot.length; i++) {
      posts.add(Post.fromMap(snapshot[i].data));
    }
    return PostList(posts);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        title: Text('Hyper Garage Sale'),
      ),
      // body is the majority of the screen.
      body: Container(
        child: new Center(
          child: _buildPostList(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewPostActivity(post: null)),
            );
          }),
    );
  }


}
