import 'package:flutter/foundation.dart';

/// "localhost" doesn't mean the same thing on every target: the Android
/// emulator runs its own network namespace, so the host machine's localhost
/// is only reachable via the special alias 10.0.2.2. Every other target
/// (iOS simulator, macOS, web, physical host) can use localhost directly.
class BaseUrl {
  static const int _port = 4002;

  static String get base {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:$_port';
    }
    return 'http://localhost:$_port';
  }

  static String get api => '$base/api';
}
