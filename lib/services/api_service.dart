import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class ApiService {
  Future<List<UserModel>> fetchUsers(int page, int perPage) async {
    final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$page&per_page=$perPage'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
