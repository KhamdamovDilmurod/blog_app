import 'package:blog_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/post_model.dart';

class DetailScreen extends StatefulWidget {
  final PostModel post;

  DetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();

  void onSave() {}

  void onDelete() {}
}

class _DetailScreenState extends State<DetailScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [kPrimaryColor, kAccentColor])),
        ),
        title: Text(
          "Favorite Screen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (isSaved) {
                widget.onDelete();
              } else {
                widget.onSave();
              }
              setState(() {
                isSaved = !isSaved;
              });
            },
            // //
            //   await launchUrl(Uri.parse('https://t.me/hello_US7'));
            //   await launch('https://t.me/hello_US7');
            icon: isSaved
                ? Icon(
              Icons.favorite,
              color: kPrimaryColor,
            )
                : Icon(
              Icons.favorite_border,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [_postSection()],
        ),
      ),
    );
  }

  Widget _postSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            widget.post.name,
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.post.color,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Container(
                decoration: BoxDecoration(color: HexColor.fromHex(widget.post.color), borderRadius: BorderRadius.circular(12)),
                height: 25,
                width: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}