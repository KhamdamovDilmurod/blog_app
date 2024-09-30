
import 'dart:async';

import 'package:blog_app/model/post_model.dart';
import 'package:blog_app/model/user_model.dart';
import 'package:stacked/stacked.dart';

import '../api/api_service.dart';
import '../db/data_base.dart';

class MainViewModel extends BaseViewModel {
  final api = ApiService();

  final DatabaseHelper dbHelper = DatabaseHelper();

  final StreamController<String> _errorStream = StreamController();


  Stream<String> get errorData {
    return _errorStream.stream;
  }

  StreamController<List<UserModel>> _usersStream = StreamController();

  Stream<List<UserModel>> get userData {
    return _usersStream.stream;
  }

  List<UserModel> users = [];

  var progressData = false;

  void getUsers() async {
    progressData = true;
    notifyListeners();
    final data = await api.getUsers(_errorStream);
    if (data != null) {
      users = data;
      _usersStream.sink.add(users);
    }
    progressData = false;
    notifyListeners();
  }


  ////////////////////////////

  StreamController<List<PostModel>> _postsStream = StreamController();

  Stream<List<PostModel>> get postData {
    return _postsStream.stream;
  }

  List<PostModel> posts = [];

  void getPosts() async {
    progressData = true;
    notifyListeners();

    // Fetch posts from API
    final fetchedPosts = await api.getPosts(_errorStream);

    // Fetch saved posts from the local database
    final savedPosts = await dbHelper.getPosts();

    if (fetchedPosts != null) {
      // Mark posts as saved if they exist in the savedPosts list
      for (var post in fetchedPosts) {
        post.isSaved = savedPosts.any((savedPost) => savedPost.id == post.id);
      }

      posts = fetchedPosts;
      _postsStream.sink.add(posts);
    }

    progressData = false;
    notifyListeners();
  }


  /////////////////

  StreamController<int> _postSaveStream = StreamController();

  Stream<int> get savedPostData {
    return _postSaveStream.stream;
  }

  int isSaved = 0;

  void savePost(PostModel post) async{
    // progressData = true;
    notifyListeners();
    final  data =  await dbHelper.insertPost(post);
    if(data!=null){
      isSaved = data;
      _postSaveStream.sink.add(data);
    }
    // progressData = false;
    notifyListeners();
  }


  ////////////////////////////

  StreamController<List<PostModel>> _savedPostsStream = StreamController();

  Stream<List<PostModel>> get savedPostsData {
    return _savedPostsStream.stream;
  }

  List<PostModel> savedPosts = [];

  void getPostsFromDB() async {
    progressData = true;
    notifyListeners();
    final data = await dbHelper.getPosts();
    if (data != null) {
      for(PostModel element in data){
        element.isSaved = true;
      }
      savedPosts = data;
      _savedPostsStream.sink.add(savedPosts);
    }
    progressData = false;
    notifyListeners();
  }

//////////////////////

  StreamController<int> _postRemoveStream = StreamController();

  Stream<int> get removedPostData {
    return _postRemoveStream.stream;
  }

  int isRemoved = 0;

  void removePost(PostModel post) async{
    // progressData = true;
    notifyListeners();
    final  data =  await dbHelper.deletePost(post.id);
    if(data!=null){
      isRemoved = data;
      _postRemoveStream.sink.add(data);
    }
    // progressData = false;
    notifyListeners();
  }



}
