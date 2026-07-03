import 'dart:convert';
import 'package:http/http.dart' as http;
import 'endpoints.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class Apis {
  static String? token;
  static Map<String, dynamic>? currentUser;

  static Future<void> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Endpoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      token = body['token'];
      currentUser = body['user'];
    } else {
      throw ApiException(body['message'] ?? 'Login failed');
    }
  }
}
