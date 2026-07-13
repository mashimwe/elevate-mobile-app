import 'package:era92_elevate/apis/api_client.dart';
import 'package:era92_elevate/apis/endpoints/course_endpoints.dart';
import 'package:era92_elevate/models/enrollment.dart';

class CourseApi {
  static Future<List<Enrollment>> fetchEnrollments({
    required String token,
    required String contactId,
  }) async {
    final body = await ApiClient.get(
      '${CourseEndpoints.enrollment}?contactId=$contactId',
      token: token,
    );

    final list = (body is List) ? body : (body['data'] as List? ?? const []);
    return list
        .map((e) => Enrollment.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
