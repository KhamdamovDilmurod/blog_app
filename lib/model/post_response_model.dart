
// Response model class
import 'package:blog_app/model/post_model.dart';
import 'package:blog_app/model/user_model.dart';

class PostResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<PostModel> data;
  final Support support;

  PostResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: (json['data'] as List<dynamic>)
          .map((userJson) => PostModel.fromJson(userJson as Map<String, dynamic>))
          .toList(),
      support: Support.fromJson(json['support']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': data.map((user) => user.toJson()).toList(),
      'support': support.toJson(),
    };
  }
}

// Support model class
class Support {
  final String url;
  final String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'text': text,
    };
  }
}