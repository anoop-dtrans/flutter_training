import 'package:equatable/equatable.dart';

import 'dart:convert';

List<UsersPost> usersPostFromJson(String str) =>
    List<UsersPost>.from(json.decode(str).map((x) => UsersPost.fromJson(x)));

String usersPostToJson(List<UsersPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersPost extends Equatable {
  const UsersPost({
    required this.userId,
    this.title,
    this.body,
  });

  final int userId;
  final String? title;
  final String? body;

  factory UsersPost.fromJson(Map<String, dynamic> json) => UsersPost(
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "body": body,
      };

  @override
  List<Object?> get props => [userId, title];
}
