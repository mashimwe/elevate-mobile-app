import 'package:flutter/material.dart';

// ── Shared Assignment model ────────────────────────────────────────────────────
// Save this file at: lib/models/assignment.dart
// Then import it in:
//   - assignment_detail_screen.dart
//   - students_assessment.dart
//   - students_home.dart
// with: import 'package:era92_elevate/models/assignment.dart';

enum AssignmentStatus { pending, submitted, graded }

class Assignment {
  Assignment({
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.deadline,
    required this.instructions,
    required this.status,
    this.score,
    this.totalMarks = 100,
    this.icon = Icons.assignment_rounded,
    this.submittedLink,
    this.submittedAt,
  });

  final String title;
  final String subject;
  final String dueDate;
  final DateTime deadline;
  final String instructions;
  AssignmentStatus status;
  final int? score;
  final int totalMarks;
  final IconData icon;
  String? submittedLink;
  DateTime? submittedAt;
}
