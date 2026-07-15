// lib/apis/timetable_api.dart

import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/timetable_endpoints.dart';

class TimetableApi {
  /// Fetch the student's timetable
  static Future<List<dynamic>> getMyTimetable({required String token}) async {
    final body = await ApiClient.get(
      TimetableEndpoints.mine,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Fetch the student's daily schedule
  static Future<List<dynamic>> getMySchedule({required String token}) async {
    final body = await ApiClient.get(
      TimetableEndpoints.schedule,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }
}
