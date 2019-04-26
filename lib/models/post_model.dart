import 'package:scoped_model/scoped_model.dart';

class Post extends Model {
  String title;
  double price;
  String description;
  List<dynamic> imageUrls;
  List<dynamic> imagePaths;
  Post() {
    imageUrls = new List<String>();
    imagePaths = new List<String>();
  }

  String getImageUrl() {
    if (imageUrls.length == 0) {
      return null;
    }
    return imageUrls[0];
  }

  setValue (String title, double price, String description, List<String> imageUrls) {
    this.title = title;
    this.price = price;
    this.description = description;
    this.imageUrls = imageUrls;
  }

  // Then notify all the listeners.
  notifyListeners();

  Post.map(dynamic obj) {
    this.title = obj['title'];
    this.price = obj['price'];
    this.description = obj['description'];
    this.imageUrls =  obj['imageUrls'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    map['imageUrls'] = imageUrls;
    return map;
  }

  Post.fromMap(Map<String, dynamic> map) {
    this.title = map['title'];
    this.price = map['price'];
    this.description = map['description'];
    this.imageUrls = map['imageUrls'];
  }
}