import 'package:era92_elevate/theme/app_theme.dart';
import 'package:era92_elevate/models/enrollment.dart';
import 'package:flutter/material.dart';

// --- Visual Mapping ---

class _CourseVisual {
  const _CourseVisual(this.icon, this.accent, this.category);
  final IconData icon;
  final Color accent;
  final String category;
}

const _courseVisuals = <String, _CourseVisual>{
  'graphic-design': _CourseVisual(
    Icons.brush_rounded,
    Color(0xFF7B1FA2),
    'Design',
  ),
  'website-development': _CourseVisual(
    Icons.laptop_mac_rounded,
    Color(0xFF1565C0),
    'Technology',
  ),
  'film-photography': _CourseVisual(
    Icons.camera_alt_rounded,
    Color(0xFFEF6C00),
    'Media',
  ),
  'alx-course': _CourseVisual(
    Icons.school_rounded,
    Color(0xFF2E7D32),
    'Program',
  ),
};

const _defaultCourseVisual = _CourseVisual(
  Icons.menu_book_rounded,
  AppColors.primary,
  'Course',
);

_CourseVisual _visualFor(String slug) =>
    _courseVisuals[slug] ?? _defaultCourseVisual;

// --- Widgets ---

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.enrollment, this.onTap});

  final Enrollment enrollment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final visual = _visualFor(enrollment.courseSlug);
    final progress = enrollment.progress / 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: visual.accent.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: visual.accent.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Text(
                    visual.category,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: visual.accent,
                    ),
                  ),
                ),
                const Spacer(),
                // Icon Box
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: visual.accent.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: visual.accent.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Icon(visual.icon, color: visual.accent, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              enrollment.courseName,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 24),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(
                  visual.accent.withValues(alpha: 0.4),
                ),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 8),
            // Progress % and Continue
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue',
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Pages ---

class CourseUnitsPage extends StatelessWidget {
  final List<Enrollment> enrollments;
  const CourseUnitsPage({super.key, required this.enrollments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Units'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: enrollments.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final enrollment = enrollments[index];
          return CourseCard(
            enrollment: enrollment,
            onTap: () {
              // Clicking a course in the list takes you to its specific details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CourseUnitDetailPage(enrollment: enrollment),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseUnitDetailPage extends StatelessWidget {
  const CourseUnitDetailPage({super.key, required this.enrollment});
  final Enrollment enrollment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final visual = _visualFor(enrollment.courseSlug);
    final progress = enrollment.progress / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(enrollment.courseName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(bottom: BorderSide(color: AppColors.divider)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: visual.accent.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(visual.icon, color: visual.accent, size: 40),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    enrollment.courseName,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: visual.accent.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      visual.category,
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 13,
                        color: visual.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Progress',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(progress * 100).toInt()}% Completed',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: visual.accent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: AppColors.divider,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              visual.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'About this course',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "This course unit covers essential concepts and practical applications in ${enrollment.courseName}. You will learn through interactive lessons and hands-on projects.",
                    style: textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                  const SizedBox(height: 40),
                  // Primary Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Continue Learning'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Main Home Page Section ---

class MyCoursesSection extends StatelessWidget {
  final List<Enrollment> enrollments;

  const MyCoursesSection({super.key, required this.enrollments});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // REQUIREMENT: "the course displayed on the home page is the first course that the student enrolled into"
    final firstEnrollment = enrollments.isNotEmpty ? enrollments.first : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Courses (${enrollments.length})',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            TextButton(
              onPressed: () {
                // REQUIREMENT: "when a student clicks on the see all widget for courses, it takes him that course unit page"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CourseUnitsPage(enrollments: enrollments),
                  ),
                );
              },
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (firstEnrollment != null)
          CourseCard(
            enrollment: firstEnrollment,
            onTap: () {
              // REQUIREMENT: "when he clicks on continue, it shows him/her the full details of that current course he/she has clicked"
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CourseUnitDetailPage(enrollment: firstEnrollment),
                ),
              );
            },
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'No courses enrolled yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
      ],
    );
  }
}
