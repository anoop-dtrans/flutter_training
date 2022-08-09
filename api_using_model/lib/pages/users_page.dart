// ignore_for_file: avoid_print

import 'package:api_using_model/pages/user_details.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:api_using_model/models/user.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> users = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  /// Fetch data
  void _fetchData() async {
    try {
      setState(() {
        loading = true;
      });
      final list = await ApiService().getUsers();
      setState(() {
        users = list;
        loading = false;
      });
    } catch (e) {
      print('API::USER - Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'Loading...' : 'Posts'),
      ),
      body: LoadingOverlay(
        isLoading: loading,
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.website ?? ''),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UserDetails(userId: user.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
