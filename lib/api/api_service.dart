

import 'dart:async';
import 'dart:io';

import 'package:blog_app/model/post_model.dart';
import 'package:dio/dio.dart';

import '../model/post_response_model.dart';
import '../model/user_model.dart';
import '../model/user_response_model.dart';
class ApiService {
  final dio = Dio();

  ApiService() {
    int time = 60000;

    dio.options = BaseOptions(
      baseUrl: 'https://reqres.in/api/',
      connectTimeout: Duration(milliseconds: time),
      receiveTimeout: Duration(milliseconds: time),
      sendTimeout: Duration(milliseconds: time),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
  }

  Future<List<UserModel>?> getUsers(StreamController<String> errorStream) async {
    try {
      // Make a GET request to fetch users
      final response = await dio.get("users");

      // Check if the response status is OK
      if (response.statusCode == 200) {
        // Access the response data directly
        final jsonResponse = response.data as Map<String, dynamic>;

        // Convert the response data to UserListResponse
        final userListResponse = UserListResponse.fromJson(jsonResponse);

        // Return the list of UserModel
        return userListResponse.data;
      } else {
        // Send an error to the stream if status code is not 200
        errorStream.add('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      // Handle Dio errors
      errorStream.add(handleError(e));
      return null;
    } catch (e) {
      // Handle general errors
      errorStream.add('Unexpected error: $e');
      return null;
    }
  }

  Future<List<PostModel>?> getPosts(StreamController<String> errorStream) async {
    try {
      // Make a GET request to fetch users
      final response = await dio.get("posts");

      // Check if the response status is OK
      if (response.statusCode == 200) {
        // Access the response data directly
        final jsonResponse = response.data as Map<String, dynamic>;

        // Convert the response data to UserListResponse
        final postResponse = PostResponse.fromJson(jsonResponse);

        // Return the list of UserModel
        return postResponse.data;
      } else {
        // Send an error to the stream if status code is not 200
        errorStream.add('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      // Handle Dio errors
      errorStream.add(handleError(e));
      return null;
    } catch (e) {
      // Handle general errors
      errorStream.add('Unexpected error: $e');
      return null;
    }
  }

  String handleError(DioException error) {
    String errorDescription = '';
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorDescription = "Connection timed out";
        break;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            final errorData = error.response?.data;
            if (errorData is Map && errorData['detail'] != null) {
              errorDescription = "Invalid page";
            } else {
              errorDescription = "Bad request";
            }
            break;
          case 401:
            final errorData = error.response?.data;
            if (errorData is Map && errorData['detail'] != null) {
              errorDescription = "Invalid page";
            } else {
              errorDescription = "Unauthorized";
            }
            break;
          case 403:
            final errorData = error.response?.data;
            if (errorData is Map && errorData['detail'] != null) {
              errorDescription = "Invalid page";
            } else {
              errorDescription = "Forbidden";
            }
            break;
          case 404:
            final errorData = error.response?.data;
            if (errorData is Map && errorData['detail'] != null) {
              errorDescription = "Invalid page";
            } else {
              errorDescription = "Resource not found";
            }
            break;
          case 500:
            final errorData = error.response?.data;
            if (errorData is Map && errorData['detail'] != null) {
              errorDescription = "Invalid page";
            } else {
              errorDescription = "Internal server error";
            }
            break;
          default:
            errorDescription =
            "Received invalid status code: ${error.response?.statusCode}";
        }
        break;
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.unknown:
        errorDescription =
        "Connection to API server failed due to internet connection";
        break;
      default:
        errorDescription = "Unexpected error occurred";
    }
    return errorDescription;
  }

}
