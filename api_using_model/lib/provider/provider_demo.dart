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
  HomeState _homeState = HomeState.initial;
  List<User> users = [];

  ProviderDemo() {
    fetchUsers();
  }

  HomeState get homeState => _homeState;

  Future<void> fetchUsers() async {
    _homeState = HomeState.loading;
    try {
      //await Future.delayed(const Duration(seconds: 5));
      final apiUsers = await ApiService().getUsers();
      users = apiUsers;
      _homeState = HomeState.loaded;
    } catch (e) {
      _homeState = HomeState.error;
    }
    notifyListeners();
  }
}
