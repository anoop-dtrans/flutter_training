import 'package:api_using_model/models/user.dart';
import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/models/users.dart';
import 'package:api_using_model/models/users_postdetails.dart';
import 'package:api_using_model/pages/user_details/user_details_viewmodel.dart';
import 'package:api_using_model/services/api_service.dart';
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
        final usersposts = context
            .select<UserDetailsViewModel, List<UsersPost>>((vm) => vm.posts);
        //final usersposts = model.posts;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Details'),
          ),
          body: Column(
            children: [
              _userDetailsWidget(context),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                  onPressed: () {
                    final model = context.read<UserDetailsViewModel>();
                    print(model.posts);
                  },
                  icon: const Icon(Icons.refresh),
                )
              ]),
              _userPostsWidget(context, usersposts),
            ],
          ),
        );
      },
    );
  }

  _userDetailsWidget(BuildContext context) {
    return FutureBuilder<Users>(
      future: ApiService().getUserDetails(userId),
      builder: (context, snapshot) {
        print('hi first');
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name:${snapshot.data?.email}'),
                const SizedBox(
                  height: 20,
                ),
                Text('Phone:${snapshot.data?.phone}')
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  _userPostsWidget(BuildContext context, List<UsersPost> usersposts) {
    //final userPosts = context.watch<UserDetailsViewModel>().posts;
    // final userPosts =
    //     context.select<UserDetailsViewModel, List<UsersPost>>((vm) => vm.posts);
    print('hi second');
    return Expanded(
      child: ListView.builder(
        itemCount: usersposts.length,
        itemBuilder: (context, index) {
          UsersPost userspost1 = usersposts[index];
          return ListTile(
            title: Text(userspost1.title ?? ''),
            subtitle: Text(userspost1.body ?? ''),
          );
        },
      ),
    );
  }
}
