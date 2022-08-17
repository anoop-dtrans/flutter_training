import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';

enum HomeState {
  initial,
  loading,
  loaded,
  error,
}

class ProviderDemo with ChangeNotifier {
  HomeState homeState = HomeState.initial;
  List<User> users = [];

  ProviderDemo() {
    _fetchUsers();
  }

  //HomeState get homeState => homeState;
  Future<void> _fetchUsers() async {
    homeState = HomeState.loading;
    try {
      //await Future.delayed(const Duration(seconds: 5));
      final apiUsers = await ApiService().getUsers();
      users = apiUsers;
      homeState = HomeState.loaded;
    } catch (e) {
      homeState = HomeState.error;
    }
    notifyListeners();
  }
}
