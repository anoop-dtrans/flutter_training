import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/user_post.dart';
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
      child: Scaffold(
        appBar: AppBar(
            //title: Text(),
            ),
      ),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
              //title: Text(),
              ),
          body: Column(
            children: [
              _userDetailsWidget(context),
              _userPostsWidget(context),
            ],
          ),
        );
      },
    );
  }

  _userDetailsWidget(BuildContext context) {
    return Container();
  }

  _userPostsWidget(BuildContext context) {
    //final userPosts = context.watch<UserDetailsViewModel>().posts;
    final userPosts =
        context.select<UserDetailsViewModel, List<UserPost>>((vm) => vm.posts);
    return ListView.builder(
      itemCount: userPosts.length,
      itemBuilder: (context, index) {
        final post = userPosts[index];
        return ListTile(
          title: Text(post.title ?? ''),
        );
      },
    );
  }
}
