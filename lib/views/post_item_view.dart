import 'package:blog_app/utils/colors.dart';
import 'package:flutter/material.dart';

import '../model/post_model.dart';

class PostItemView extends StatefulWidget {
  final PostModel posts;
  final VoidCallback onPressed;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const PostItemView(
      {Key? key,
      required this.posts,
      required this.onPressed,
      required this.onSave,
      required this.onDelete})
      : super(key: key);

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  bool isSaved = false;

  @override
  void initState() {
    isSaved = widget.posts.isSaved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(.4),
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 3,
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(12),
              ),
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: Text(
                widget.posts.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.posts.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    if(isSaved){
                      widget.onDelete();
                    } else {
                      widget.onSave();
                    }
                  },
                  icon: isSaved
                      ? Icon(
                          Icons.favorite,
                          color: kPrimaryColor,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: kPrimaryColor,
                        )),
            )
          ],
        ),
      ),
    );
  }
}
