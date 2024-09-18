import 'package:blog_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../screens/detail/detail_screen.dart';

class ItemViewPost extends StatefulWidget {
  final PostModel post;
  final VoidCallback onPressed;
  const ItemViewPost({Key? key, required this.post, required this.onPressed}) : super(key: key);

  @override
  _ItemViewPostState createState() => _ItemViewPostState();
}

class _ItemViewPostState extends State<ItemViewPost> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kDarkGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 80,
              height: 80,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    widget.post.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
