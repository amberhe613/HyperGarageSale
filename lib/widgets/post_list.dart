import 'package:flutter/material.dart';
import 'package:winter2019/widgets/post_card.dart';
import 'package:winter2019/models/post_model.dart';

class PostList extends StatelessWidget {
  final List<Post> itemPosts;

  PostList(this.itemPosts);

  ListView _buildList(context) {
    return new ListView.builder(
      itemCount: itemPosts.length,
      itemBuilder: (context, int) {
        return new PostCard(itemPosts[int]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
