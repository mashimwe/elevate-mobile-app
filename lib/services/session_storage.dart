import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StoredSession {
  StoredSession({required this.token, required this.userJson});
  final String token;
  final Map<String, dynamic> userJson;
}

/// Persists the auth session so a user stays logged in incase app restarts.
class SessionStorage {
  static const _tokenKey = 'era92_elevate_token';
  static const _userKey = 'era92_elevate_user';

  Future<void> saveSession({
    required String token,
    required Map<String, dynamic> userJson,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userJson));
  }

  Future<StoredSession?> readSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final userRaw = prefs.getString(_userKey);
    if (token == null || userRaw == null) return null;

    return StoredSession(
      token: token,
      userJson: jsonDecode(userRaw) as Map<String, dynamic>,
    );
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
