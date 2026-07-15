// lib/apis/workshops_api.dart

import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/workshops_endpoints.dart';

class WorkshopsApi {
  /// Fetch all workshops
  static Future<List<dynamic>> getWorkshops({required String token}) async {
    final body = await ApiClient.get(
      WorkshopsEndpoints.all,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Fetch a single workshop by ID
  static Future<Map<String, dynamic>> getWorkshopById({
    required int id,
    required String token,
  }) async {
    final body = await ApiClient.get(
      WorkshopsEndpoints.byId(id),
      token: token,
    );
    return body as Map<String, dynamic>;
  }
}
