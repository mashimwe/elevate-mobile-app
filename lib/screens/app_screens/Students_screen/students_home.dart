import 'dart:async';
import 'package:era92_elevate/componets/announcements.dart';
import 'package:era92_elevate/componets/todays_class_card.dart';
import 'package:era92_elevate/models/assessment.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/assignment_detail_screen.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/students_assessment.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ── Today's class model ────────────────────────────────────────────────────────

class _ClassItem {
  const _ClassItem({
    required this.subject,
    required this.teacher,
    required this.start,
    required this.end,
    this.isLive = false,
    this.icon = Icons.menu_book_rounded,
  });
  final String subject;
  final String teacher;
  final String start;
  final String end;
  final bool isLive;
  final IconData icon;
}

const _todaysClasses = [
  _ClassItem(
    subject: 'Website Development',
    teacher: 'Mr. Bashir Kasujja',
    start: '09:00 AM',
    end: '11:00 AM',
    isLive: true,
    icon: Icons.laptop_mac_rounded,
  ),
  _ClassItem(
    subject: 'Fellowship',
    teacher: 'Pastor James',
    start: '12:00 PM',
    end: '01:00 PM',
    icon: Icons.people_rounded,
  ),
  _ClassItem(
    subject: 'Public Speaking',
    teacher: 'Ms. Grace Apio',
    start: '02:00 PM',
    end: '03:30 PM',
    icon: Icons.mic_rounded,
  ),
];

// ── Recent assessments — uses the shared Assignment model ──────────────────────
// These mirror the graded entries in students_assessment.dart.
// When you connect a real backend, replace this with a data fetch.

final _recentAssessments = [
  Assignment(
    title: 'HTML & CSS Landing Page',
    subject: 'Website Development',
    dueDate: 'Jun 20, 2025',
    deadline: DateTime(2025, 6, 20, 23, 59),
    instructions:
        'Build a responsive landing page using HTML and CSS. Your page must include a navigation bar, hero section, features section, and a footer. Upload your project to GitHub and submit the repository link.',
    status: AssignmentStatus.graded,
    score: 88,
    totalMarks: 100,
    icon: Icons.laptop_mac_rounded,
    submittedAt: DateTime(2025, 6, 19, 14, 32),
  ),
  Assignment(
    title: 'Speech on Leadership',
    subject: 'Public Speaking',
    dueDate: 'Jun 22, 2025',
    deadline: DateTime(2025, 6, 22, 17, 0),
    instructions:
        'Prepare a 5-minute speech on a leadership figure of your choice. Record yourself delivering the speech and upload the video to Google Drive. Submit the shareable link below.',
    status: AssignmentStatus.graded,
    score: 74,
    totalMarks: 100,
    icon: Icons.mic_rounded,
    submittedAt: DateTime(2025, 6, 21, 9, 10),
  ),
];

// ── Home screen ────────────────────────────────────────────────────────────────

class StudentsHome extends StatefulWidget {
  const StudentsHome({super.key});

  @override
  State<StudentsHome> createState() => _StudentsHomeState();
}

class _StudentsHomeState extends State<StudentsHome> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_pageController.hasClients) return;
      final next = (_currentPage + 1) % _recentAssessments.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Navigates to the full AssignmentDetailScreen for the tapped assessment
  void _openDetail(Assignment assignment) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AssignmentDetailScreen(assignment: assignment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back 👋',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Student',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Announcement banner ──────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnnouncementBanner(),
              ),
              const SizedBox(height: 28),

              // ── Today's Classes ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Classes",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${_todaysClasses.length} classes',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              SizedBox(
                height: 228,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _todaysClasses.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final c = _todaysClasses[index];
                    return TodaysClassCard(
                      subjectName: c.subject,
                      teacherName: c.teacher,
                      startTime: c.start,
                      endTime: c.end,
                      isLive: c.isLive,
                      icon: c.icon,
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // ── Recent Assessments header ────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Assessments',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // View all assessments button (top-right)
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const StudentsAssessment(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppGradients.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View all assessments',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 12,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ── Auto-scrolling assessment cards ──────────────────────────
              SizedBox(
                height: 210,
                child: PageView.builder(
                  controller: _pageController,
                  padEnds: false,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemCount: _recentAssessments.length,
                  itemBuilder: (context, index) {
                    final assignment = _recentAssessments[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 20 : 8,
                        right: index == _recentAssessments.length - 1 ? 20 : 8,
                      ),
                      child: _RecentAssessmentCard(
                        assignment: assignment,
                        // "View Details" opens the full AssignmentDetailScreen
                        onViewDetails: () => _openDetail(assignment),
                      ),
                    );
                  },
                ),
              ),

              // ── Page indicator dots ──────────────────────────────────────
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _recentAssessments.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentPage == i ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? AppColors.primary
                          : AppColors.divider,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Recent assessment card ─────────────────────────────────────────────────────

class _RecentAssessmentCard extends StatelessWidget {
  const _RecentAssessmentCard({
    required this.assignment,
    required this.onViewDetails,
  });

  final Assignment assignment;
  final VoidCallback onViewDetails;

  Color get _statusColor {
    switch (assignment.status) {
      case AssignmentStatus.graded:
        return const Color(0xFF06D6A0);
      case AssignmentStatus.submitted:
        return const Color(0xFF90E0EF);
      case AssignmentStatus.pending:
        return const Color(0xFFFFD166);
    }
  }

  String get _statusLabel {
    switch (assignment.status) {
      case AssignmentStatus.graded:
        return 'Graded';
      case AssignmentStatus.submitted:
        return 'Submitted';
      case AssignmentStatus.pending:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 56,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: icon + title + status badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  assignment.icon,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      assignment.subject,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status badge + score (if graded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _statusColor.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                  if (assignment.score != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${assignment.score}/${assignment.totalMarks}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description (2 lines max)
          Text(
            assignment.instructions,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textLight,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          // Submitted date (if available)
          if (assignment.submittedAt != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 11,
                  color: Color(0xFF06D6A0),
                ),
                const SizedBox(width: 4),
                Text(
                  'Submitted: ${_formatDate(assignment.submittedAt!)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF06D6A0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],

          const Spacer(),

          // Bottom row: due date + View Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 11,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    assignment.dueDate,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              // View Details → opens AssignmentDetailScreen
              GestureDetector(
                onTap: onViewDetails,
                child: Row(
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 10,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '${months[dt.month]} ${dt.day}, ${dt.year}  ·  $hour:$min $period';
  }
}
