import 'dart:convert';

import 'package:api_using_model/common/constants.dart';
import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/models/users_post_details.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../models/user.dart';

class ApiService {
  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? Constants.baseUrl;

  final String baseUrl;

  /// Get Users
  Future<List<User>> getUsers() async {
    final response = await _getData('users');
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      return [];
    }
  }

  // Future<User> getUserPosts(int userId) async {
  //   final response = await _getData('users/$userId/posts');
  //   if (response.statusCode == 200) {
  //     final list = jsonDecode(response.body) as List;
  //     return list.map((e) => UserPost.fromJson(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }

  /// Get User Posts
  Future<List<UsersPost>> getUserPosts(int userId) async {
    final response = await _getData('users/$userId/posts');
    if (response.statusCode == 200) {
      return usersPostFromJson(response.body);
    } else {
      return [];
    }
  }

  /// Get Post Details
  Future<UserPost?> getPostDetails(int postId) async {
    final response = await _getData('posts/$postId');
    if (response.statusCode == 200) {
      return UserPost.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  /// Get User Details
  // Future<Users?> getUserDetails(int postId) async {
  //   final response = await _getData('users/$postId');
  //   if (response.statusCode == 200) {
  //     return Users.fromJson(jsonDecode(response.body));
  //   } else {
  //     return null;
  //   }
  // }
  Future<User> getUserDetails(userId) async {
    try {
      final response = await _getData('users/$userId');
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> _getData(
    String urlPath, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(path.join(baseUrl, urlPath));
      final response = await http.get(uri);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
