class Enrollment {
  Enrollment({
    required this.id,
    required this.courseId,
    required this.courseName,
    required this.courseSlug,
    required this.hubName,
    required this.status,
    required this.progress,
    required this.enrolledAt,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    final courseName = json['courseName']?.toString() ??
        (json['course'] as Map<String, dynamic>?)?['name']?.toString() ??
        '';

    // The live server doesn't always return `courseSlug` (undocumented gap
    // vs. SERVER_API.md), so derive one from the course name as a fallback
    // for the client-side icon/color lookup.
    final slug = json['courseSlug']?.toString() ??
        courseName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');

    return Enrollment(
      id: json['id']?.toString() ?? '',
      courseId: json['courseId']?.toString() ?? '',
      courseName: courseName,
      courseSlug: slug,
      hubName: json['hubName']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      enrolledAt: json['enrolledAt']?.toString() ?? '',
    );
  }

  final String id;
  final String courseId;
  final String courseName;
  final String courseSlug;
  final String hubName;
  final String status;
  final int progress;
  final String enrolledAt;
}
