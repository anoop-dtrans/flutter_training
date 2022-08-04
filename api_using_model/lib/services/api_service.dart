import 'package:api_using_model/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../models/user.dart';

class ApiService {
  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? Constants.baseUrl;

  final String baseUrl;

  Future<List<User>> getPosts() async {
    try {
      final uri = Uri.parse(path.join(baseUrl, 'users'));
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return postFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
