// lib/apis/endpoints/workshops_endpoints.dart

import 'package:era92_elevate/apis/base_url.dart';

class WorkshopsEndpoints {
  WorkshopsEndpoints._();

  /// GET — all workshops
  static String get all => '${BaseUrl.api}/workshops';

  /// GET — a single workshop by ID
  static String byId(int id) => '${BaseUrl.api}/workshops/$id';
}
