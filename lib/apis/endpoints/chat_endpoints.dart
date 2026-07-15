// lib/apis/endpoints/chat_endpoints.dart

import 'package:era92_elevate/apis/base_url.dart';

class ChatEndpoints {
  ChatEndpoints._();

  /// GET — all chat rooms for the logged-in user
  static String get rooms => '${BaseUrl.api}/chat/rooms';

  /// GET — chat contacts
  static String get contacts => '${BaseUrl.api}/chat/contacts';

  /// GET — messages in a room
  static String messages(int roomId) =>
      '${BaseUrl.api}/chat/rooms/$roomId/messages';

  /// POST — send a message in a room
  static String sendMessage(int roomId) =>
      '${BaseUrl.api}/chat/rooms/$roomId/messages';
}
