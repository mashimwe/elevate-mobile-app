// lib/apis/endpoints/announcements_endpoints.dart

import 'package:era92_elevate/apis/base_url.dart';

class AnnouncementsEndpoints {
  AnnouncementsEndpoints._();

  /// GET — all announcements
  static String get all => '${BaseUrl.api}/announcements';

  /// GET — all events
  static String get events => '${BaseUrl.api}/announcements/events';
}
