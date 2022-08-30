import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';

class UserDetailsViewModel extends ChangeNotifier {
  /// Default Constructor
  UserDetailsViewModel(this.userId);

  /// Required to get started
  final int userId;

  /// This will be refreshed multiple times
  User? _user;
  User get user => _user ?? User();

  List<UserPost>? _posts;
  List<UserPost> get posts => _posts ?? [];

  /// Get User Posts
  Future<void> getUserPosts() async {
    try {
      final posts = await ApiService().getUserPosts(userId);
    } catch (e) {}
  }
}
