// lib/apis/endpoints/assignments_endpoints.dart

import 'package:era92_elevate/apis/base_url.dart';

class AssignmentsEndpoints {
  AssignmentsEndpoints._();

  /// GET — assignments for the logged-in student
  static String get mine => '${BaseUrl.api}/assignments/mine';

  /// GET — all assignments
  static String get all => '${BaseUrl.api}/assignments';

  /// GET — a single assignment by ID
  static String byId(int id) => '${BaseUrl.api}/assignments/$id';

  /// POST — submit an assignment
  static String submit(int id) => '${BaseUrl.api}/assignments/$id/submissions';

  /// GET — submissions for an assignment
  static String submissions(int id) =>
      '${BaseUrl.api}/assignments/$id/submissions';
}
