import 'package:era92_elevate/apis/base_url.dart';

class CourseEndpoints {
  static String get courses => '${BaseUrl.api}/courses/course';
  static String get combo => '${BaseUrl.api}/courses/combo';
  static String get enrollment => '${BaseUrl.api}/courses/enrollment';
}
