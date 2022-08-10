import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';

enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class ProviderDemo with ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  List<User> users = [];

  ProviderDemo() {
    _fetchUsers();
  }

  HomeState get homeState => _homeState;
  Future<void> _fetchUsers() async {
    _homeState = HomeState.Loading;
    try {
      await Future.delayed(const Duration(seconds: 5));
      final apiusers = await ApiService().getUsers();
      users = apiusers;
      _homeState = HomeState.Loaded;
    } catch (e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
}
