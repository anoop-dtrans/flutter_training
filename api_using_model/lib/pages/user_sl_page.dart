// ignore_for_file: avoid_print

import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/provider/provider_demo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_details_bloc/user_details_bloc_page.dart';

class UsersStatelessPage extends StatelessWidget {
  const UsersStatelessPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserChangeNotifier();
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Posts'),
              actions: [
                IconButton(
                  onPressed: () {
                    final model = context.read<UserChangeNotifier>();
                    model.fetchUsers();
                    print(model.users);
                  },
                  icon: const Icon(Icons.refresh),
                )
              ],
            ),
            body: _body(context),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    final model = context.watch<UserChangeNotifier>();
    final users = model.users;

    switch (model.homeState) {
      case HomeState.loading:
        return _loadingWidget(context);
      case HomeState.error:
        return _emptyUserWidget(context);
      case HomeState.loaded:
        return _userListView(context, users);
      case HomeState.initial:
        return _loadingWidget(context);
    }
  }

  Widget _loadingWidget(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _emptyUserWidget(BuildContext context) {
    return const Center(
      child: Text('No users found!!!'),
    );
  }

  Widget _userListView(BuildContext context, List<User> users) {
    return Container(
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
                  builder: (_) => UserDetailsBlocPage(
                    userId: user.id,
                    user: user,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
