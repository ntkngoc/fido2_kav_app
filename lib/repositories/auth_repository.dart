import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../utils/api_endpoints.dart';

class AuthRepository {
  Future<UserModel?> login(String username, String password) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to log in');
    }
  }
}
