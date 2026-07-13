import 'package:era92_elevate/apis/base_url.dart';

class AuthEndpoints {
  static String get login => '${BaseUrl.api}/auth/login';
  static String get profile => '${BaseUrl.api}/auth/profile';
  static String get me => '${BaseUrl.api}/auth/me';
  static String get logout => '${BaseUrl.api}/auth/logout';
  static String get forgotPassword => '${BaseUrl.api}/auth/forgot-password';
}
