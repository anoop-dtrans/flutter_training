import 'dart:convert';

import 'package:api_using_model/common/constants.dart';
import 'package:api_using_model/models/user_post.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../models/user.dart';

class ApiService {
  ApiService({String? baseUrl, String? baseUrl1})
      : baseUrl = baseUrl ?? Constants.baseUrl,
        baseUrl1 = baseUrl ?? Constants.baseUrl1;

  final String baseUrl;
  final String baseUrl1;
  Future<List<User>> getPosts() async {
    try {
      final uri = Uri.parse(path.join(baseUrl, 'users'));
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return postFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<UserPost> getUserPosts(index) async {
    try {
      final uri = Uri.parse(path.join(baseUrl1, '$index'));
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return UserPost.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
