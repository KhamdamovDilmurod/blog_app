import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmerView extends StatefulWidget {
  const PostShimmerView({super.key});

  @override
  State<PostShimmerView> createState() => _PostShimmerViewState();
}

class _PostShimmerViewState extends State<PostShimmerView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 100,
            child: Shimmer.fromColors(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              baseColor: Colors.white,
              highlightColor: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 100,
            child: Shimmer.fromColors(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              baseColor: Colors.white,
              highlightColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
