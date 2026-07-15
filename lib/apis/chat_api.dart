// lib/apis/chat_api.dart

import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/chat_endpoints.dart';

class ChatApi {
  /// Fetch all chat rooms
  static Future<List<dynamic>> getChatRooms({required String token}) async {
    final body = await ApiClient.get(
      ChatEndpoints.rooms,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Fetch chat contacts
  static Future<List<dynamic>> getChatContacts({required String token}) async {
    final body = await ApiClient.get(
      ChatEndpoints.contacts,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Fetch messages in a chat room
  static Future<List<dynamic>> getMessages({
    required int roomId,
    required String token,
  }) async {
    final body = await ApiClient.get(
      ChatEndpoints.messages(roomId),
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Send a message in a chat room
  static Future<void> sendMessage({
    required int roomId,
    required String message,
    required String token,
  }) async {
    await ApiClient.post(
      ChatEndpoints.sendMessage(roomId),
      body: {'message': message, 'content': message},
      token: token,
    );
  }
}
