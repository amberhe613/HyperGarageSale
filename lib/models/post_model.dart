import 'package:scoped_model/scoped_model.dart';

class Post extends Model {
  String title;
  double price;
  String description;
  List<String> imageUrls;
  List<String> imagePaths;
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
}