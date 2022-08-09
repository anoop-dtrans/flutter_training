import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: FutureBuilder<UserPost?>(
          future: ApiService().getPostDetails(userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Title:${snapshot.data?.title}'),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Body:${snapshot.data?.body}')
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
