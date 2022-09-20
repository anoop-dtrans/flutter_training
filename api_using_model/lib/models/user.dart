import 'package:equatable/equatable.dart';

import 'dart:convert';

List<User> postFromJson(String str) {
  List users = json.decode(str);
  return List<User>.from(users.map((x) => User.fromJson(x)));
}

String postToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User extends Equatable {
  const User({
    this.id = 0,
    this.name = '',
    this.website,
    this.email,
  });

  static const empty = User();

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        website: json["website"],
        email: json["email"],
      );

  final int id;
  final String name;
  final String? website;
  final String? email;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "website": website,
        "email": email,
      };

  bool get isEmpty => id == 0;

  @override
  List<Object?> get props => [id, name, website, email];
}
