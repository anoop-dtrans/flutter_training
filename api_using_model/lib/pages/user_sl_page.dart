// ignore_for_file: avoid_print

import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/pages/user_details.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:api_using_model/models/user.dart';
import 'package:flutter/material.dart';

class UsersStatelessPage extends StatelessWidget {
  const UsersStatelessPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<User>>(
        future: ApiService().getPosts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final posts = snapshot.data ?? [];
              return posts.isNotEmpty
                  ? _userListView(context, posts)
                  : _emptyUserWidget(context);
            default:
              return _loadingWidget(context);
          }
        },
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _emptyUserWidget(BuildContext context) {
    return const Center(
      child: Text('No users found!!!'),
    );
  }

  Widget _userListView(BuildContext context, List<User> posts) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          User post = posts[index];
          return ListTile(
            title: Text(post.name),
            subtitle: Text(post.website ?? ''),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx1) => UserDetails(index: post.id)));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => UserDetails(index),
              //     ),
              //   );
            },
          );
        },
      ),
    );
  }
}
