import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/users_post_details.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';

class UserDetailsViewModel extends ChangeNotifier {
  /// Default Constructor
  UserDetailsViewModel(this.userId);

  Future<void> initialize() async {
    // print(1);

    // asyncTask.execute.then((value){
    //   print(2);
    // });

    // Future.microtask(() => print(3));

    await Future.wait([getUserDetails(), _getUserPosts()]);
    notifyListeners();
  }

  /// Required to get started
  final int userId;

  /// This will be refreshed multiple times
  User? _user;
  User get user => _user ?? User();

  List<UsersPost>? _posts;
  List<UsersPost> get posts => _posts ?? [];

  String? errorMessage;

  Future<void> getUserDetails() async {
    try {
      final user = await ApiService().getUserDetails(userId);
      _user = user;
    } catch (e) {
      errorMessage = 'Unable to fetch the user details';
    }
  }

  /// Get User Posts
  Future<void> getUserPosts() async {
    await _getUserPosts();
    notifyListeners();
  }

  Future<void> _getUserPosts() async {
    try {
      final apiUsers = await ApiService().getUserPosts(userId);
      _posts = apiUsers;
    } catch (e) {
      errorMessage = 'Unable to fetch the user details';
    }
  }
}
