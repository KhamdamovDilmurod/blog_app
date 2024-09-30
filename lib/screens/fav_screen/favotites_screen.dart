import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

import '../../utils/utils.dart';
import '../../views/post_item_view.dart';
import '../../views/post_shimmer_view.dart';
import '../view_model.dart';

class FavotitesScreen extends StatefulWidget {
  const FavotitesScreen({Key? key}) : super(key: key);

  @override
  _FavotitesScreenState createState() => _FavotitesScreenState();
}

class _FavotitesScreenState extends State<FavotitesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () {
          return MainViewModel();
        },
        builder:
            (BuildContext context, MainViewModel viewModel, Widget? child) {
          return Stack(
            children: [
              Column(
                children: [
                  (viewModel.progressData)
                      ? Expanded(child: PostShimmerView())
                      : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        scrollDirection: Axis.vertical,
                        itemCount: viewModel.savedPosts.length,
                        itemBuilder: (_, position) {
                          var post = viewModel.savedPosts[position];
                          return PostItemView(
                            posts: post, onPressed: () {},
                            onSave: () {
                              viewModel.savePost(post);
                            },
                            onDelete: () {
                              viewModel.removePost(post);
                            },);
                        }),
                  ),
                ],
              ),
              // if (viewModel.progressData) showAsProgress(),
            ],
          );
        },
        onViewModelReady: (viewModel) {
          viewModel.getPostsFromDB();
          viewModel.errorData.listen((event) {
            showError(context, event);
          });
        },
      ),
    );
  }
}

