// lib/apis/announcements_api.dart

import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/announcements_endpoints.dart';

class AnnouncementsApi {
  /// Fetch all announcements
  static Future<List<dynamic>> getAnnouncements({required String token}) async {
    final body = await ApiClient.get(
      AnnouncementsEndpoints.all,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Fetch all events
  static Future<List<dynamic>> getEvents({required String token}) async {
    final body = await ApiClient.get(
      AnnouncementsEndpoints.events,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }
}
