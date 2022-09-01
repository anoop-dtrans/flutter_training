import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/models/users_postdetails.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';

class UserDetailsViewModel extends ChangeNotifier {
  /// Default Constructor
  UserDetailsViewModel(this.userId) {
    getUserPosts(userId);
  }

  /// Required to get started
  final int userId;

  /// This will be refreshed multiple times
  User? _user;
  User get user => _user ?? User();

  List<UsersPost>? _posts;
  List<UsersPost> get posts => _posts ?? [];

  /// Get User Posts
  Future<void> getUserPosts(userId) async {
    try {
      //await Future.delayed(const Duration(seconds: 5));
      final apiUsers = await ApiService().getUserPosts(userId);
      _posts = apiUsers;
    } catch (e) {
      //_homeState = HomeStatePost.error;
    }
    notifyListeners();
  }
  
}
