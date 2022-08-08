import 'package:api_using_model/models/user_post.dart';
import 'package:api_using_model/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: FutureBuilder<UserPost>(
          future: ApiService().getUserPosts(index),
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
