// lib/apis/endpoints/timetable_endpoints.dart

import 'package:era92_elevate/apis/base_url.dart';

class TimetableEndpoints {
  TimetableEndpoints._();

  /// GET — timetable for the logged-in student
  static String get mine => '${BaseUrl.api}/timetable/mine';

  /// GET — full timetable
  static String get all => '${BaseUrl.api}/timetable';

  /// GET — student's daily schedule
  static String get schedule => '${BaseUrl.api}/students/me/schedule';
}
