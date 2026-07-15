// lib/apis/assignments_api.dart

import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/assignments_endpoints.dart';

class AssignmentsApi {
  /// Fetch assignments for the logged-in student
  static Future<List<dynamic>> getMyAssignments({required String token}) async {
    final body = await ApiClient.get(
      AssignmentsEndpoints.mine,
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }

  /// Fetch a single assignment by ID
  static Future<Map<String, dynamic>> getAssignmentById({
    required int id,
    required String token,
  }) async {
    final body = await ApiClient.get(
      AssignmentsEndpoints.byId(id),
      token: token,
    );
    return body as Map<String, dynamic>;
  }

  /// Submit an assignment with a link
  static Future<void> submitAssignment({
    required int assignmentId,
    required String link,
    required String token,
  }) async {
    await ApiClient.post(
      AssignmentsEndpoints.submit(assignmentId),
      body: {'submissionLink': link, 'link': link},
      token: token,
    );
  }

  /// Fetch submissions for an assignment
  static Future<List<dynamic>> getSubmissions({
    required int assignmentId,
    required String token,
  }) async {
    final body = await ApiClient.get(
      AssignmentsEndpoints.submissions(assignmentId),
      token: token,
    );
    if (body is List) return body;
    if (body is Map && body['data'] is List) return body['data'] as List;
    return [];
  }
}
