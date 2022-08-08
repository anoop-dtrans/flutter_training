// To parse this JSON data, do
//
//     final userPost = userPostFromJson(jsonString);

import 'dart:convert';

// UserPost userPostFromJson(String str) => UserPost.fromJson(json.decode(str));

// String userPostToJson(UserPost data) => json.encode(data.toJson());

class UserPost {
  UserPost({
    required this.id,
    this.title,
    this.body,
  });

  int id;
  String? title;
  String? body;

  factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
      };
}
