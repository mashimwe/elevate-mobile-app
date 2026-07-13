import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/auth_endpoints.dart';
import 'package:era92_elevate/models/app_user.dart';

class LoginResult {
  LoginResult({required this.token, required this.user});
  final String token;
  final AppUser user;
}

class AuthApi {
  static Future<LoginResult> login({
    required String username,
    required String password,
  }) async {
    final body = await ApiClient.post(
      AuthEndpoints.login,
      body: {'username': username, 'password': password},
    );

    return LoginResult(
      token: body['token'].toString(),
      user: AppUser.fromJson(body['user'] as Map<String, dynamic>),
    );
  }
}
