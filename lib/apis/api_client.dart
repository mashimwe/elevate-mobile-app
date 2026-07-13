import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  ApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Thin wrapper around [http] that attaches JSON headers, an optional bearer
/// token, and turns non-2xx responses into an [ApiException] using the
/// server's `{ message, statusCode, error }` error shape.
class ApiClient {
  static Map<String, String> _headers(String? token) => {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  static dynamic _parse(http.Response response) {
    final body = response.body.isEmpty ? null : jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = (body is Map && body['message'] != null)
        ? body['message'].toString()
        : 'Request failed (${response.statusCode})';
    throw ApiException(message);
  }

  static Future<dynamic> get(String url, {String? token}) async {
    final response = await http.get(Uri.parse(url), headers: _headers(token));
    return _parse(response);
  }

  static Future<dynamic> post(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: _headers(token),
      body: jsonEncode(body ?? {}),
    );
    return _parse(response);
  }
}
