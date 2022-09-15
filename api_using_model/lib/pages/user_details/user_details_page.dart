import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/users_post_details.dart';
import 'package:api_using_model/pages/user_details/user_details_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({
    Key? key,
    required this.userId,
    this.user,
  }) : super(key: key);

  final int userId;

  final User? user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDetailsViewModel(userId),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<UserDetailsViewModel>().getUserPosts();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
          body: Column(
            children: [
              _userDetailsWidget(context),
              Expanded(child: _userPostsWidget(context)),
            ],
          ),
        );
      },
    );
  }

  Widget _userDetailsWidget(BuildContext context) {
    final user = context.select<UserDetailsViewModel, User>((vm) => vm.user);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            color: Colors.grey,
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name),
                const SizedBox(height: 20),
                Text(user.email ?? '')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userPostsWidget(BuildContext context) {
    final usersPosts =
        context.select<UserDetailsViewModel, List<UsersPost>>((vm) => vm.posts);
    return ListView.builder(
      itemCount: usersPosts.length,
      itemBuilder: (context, index) {
        UsersPost post = usersPosts[index];
        return ListTile(
          title: Text(post.title ?? ''),
          subtitle: Text(post.body ?? ''),
        );
      },
    );
  }
}
