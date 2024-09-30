import 'dart:async';
import 'package:blog_app/screens/detail/detail_screen.dart';
import 'package:blog_app/utils/colors.dart';
import 'package:blog_app/views/post_item_view.dart';
import 'package:blog_app/views/post_shimmer_view.dart';
import 'package:blog_app/views/user_shimmer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/utils.dart';
import '../view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  Timer? _timer;

  Future<void> openTelegramLink() async {
    const url = 'https://t.me/hello_US7';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kPrimaryColor, kAccentColor])),
        ),
        title: Text(
          "Blog Application",
          style: TextStyle(color: Colors.white, fontFamily: 'lobster'),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await launchUrl(Uri.parse('https://t.me/hello_US7'));
                await launch('https://t.me/hello_US7');
              },
              icon: Icon(
                CupertinoIcons.share,
              ))
        ],
      ),
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
                  viewModel.progressData
                      ? UserShimmerView()
                      : SizedBox(
                          height: 130,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.users.length,
                              itemBuilder: (_, position) {
                                var user = viewModel.users[position];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          user.avatar,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          user.firstName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 200,
                          child: PageView(
                            controller: _pageController,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/img_1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/img_2.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/img_3.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 3,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.black,
                              dotHeight: 10,
                              dotWidth: 10,
                              expansionFactor: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (viewModel.progressData)
                      ? Expanded(child: PostShimmerView())
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              scrollDirection: Axis.vertical,
                              itemCount: viewModel.posts.length,
                              itemBuilder: (_, position) {
                                var post = viewModel.posts[position];
                                return PostItemView(
                                  posts: post,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                DetailScreen(post: post)));
                                  },
                                  onSave: () {
                                    viewModel.savePost(post);
                                  },
                                  onDelete: () {
                                    viewModel.removePost(post);
                                  },
                                );
                              }),
                        ),
                ],
              ),
              // if (viewModel.progressData) showAsProgress(),
            ],
          );
        },
        onViewModelReady: (viewModel) {
          viewModel.getUsers();
          viewModel.getPosts();
          viewModel.errorData.listen((event) {
            showError(context, event);
          });
        },
      ),
    );
  }
}
