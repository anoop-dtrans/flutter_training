import 'dart:convert';

List<User> postFromJson(String str) {
  List users = json.decode(str);
  return List<User>.from(users.map((x) => User.fromJson(x)));
}

String postToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id = 0,
    this.name = '',
    this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        website: json["website"],
      );

  final int id;
  final String name;
  final String? website;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "website": website,
      };

  bool get isEmpty => id == 0;
}
