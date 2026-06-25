import 'package:era92_elevate/models/assessment.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/assignment_detail_screen.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ── Sample data ────────────────────────────────────────────────────────────────

final _assignments = [
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
  Assignment(
    title: 'JavaScript Functions Quiz',
    subject: 'Website Development',
    dueDate: 'Jun 25, 2025',
    deadline: DateTime(2025, 6, 25, 23, 59),
    instructions:
        'Complete the JavaScript functions quiz on the learning portal. Once done, take a screenshot of your result page, upload it to Google Drive, and submit the link here.',
    status: AssignmentStatus.submitted,
    icon: Icons.laptop_mac_rounded,
    submittedLink: 'https://drive.google.com/file/example',
    submittedAt: DateTime(2025, 6, 24, 18, 45),
  ),
  Assignment(
    title: 'Group Reflection Essay',
    subject: 'Fellowship',
    dueDate: 'Jun 28, 2025',
    deadline: DateTime(2025, 6, 28, 17, 0),
    instructions:
        'Write a 500-word group reflection essay on this term\'s fellowship activities. Discuss what you learned, your contributions, and areas for growth. Submit a Google Docs link with comment access enabled.',
    status: AssignmentStatus.pending,
    icon: Icons.people_rounded,
  ),
  Assignment(
    title: 'Debate Preparation',
    subject: 'Public Speaking',
    dueDate: 'Jul 2, 2025',
    deadline: DateTime(2025, 7, 2, 17, 0),
    instructions:
        'Prepare arguments for both sides of the topic: "Social media does more harm than good." Write your points in a document, record a 3-minute practice debate, and submit the Google Drive link to your video.',
    status: AssignmentStatus.pending,
    icon: Icons.mic_rounded,
  ),
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class StudentsAssessment extends StatefulWidget {
  const StudentsAssessment({super.key});

  @override
  State<StudentsAssessment> createState() => _StudentsAssessmentState();
}

class _StudentsAssessmentState extends State<StudentsAssessment>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  List<Assignment> get _graded =>
      _assignments.where((a) => a.status == AssignmentStatus.graded).toList();
  List<Assignment> get _pending =>
      _assignments.where((a) => a.status == AssignmentStatus.pending).toList();
  List<Assignment> get _submitted => _assignments
      .where((a) => a.status == AssignmentStatus.submitted)
      .toList();

  double get _averageScore {
    if (_graded.isEmpty) return 0;
    final total = _graded.fold<int>(0, (sum, a) => sum + (a.score ?? 0));
    return total / _graded.length;
  }

  void _onSubmitted(Assignment assignment, String link) {
    setState(() {
      assignment.status = AssignmentStatus.submitted;
      assignment.submittedLink = link;
      assignment.submittedAt = DateTime.now(); // ← record submission time
    });
    _tab.animateTo(1);
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Assessments',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Track your marks and assignments',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SummaryCard(
                average: _averageScore,
                graded: _graded.length,
                pending: _pending.length,
                submitted: _submitted.length,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _AssessmentTabBar(controller: _tab),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [
                  _AssignmentList(
                    items: _pending,
                    emptyMessage: 'No pending assignments 🎉',
                    emptySubtitle: "You're all caught up.",
                    onSubmitted: _onSubmitted,
                    onTap: _openDetail,
                  ),
                  _AssignmentList(
                    items: _submitted,
                    emptyMessage: 'Nothing submitted yet',
                    emptySubtitle: 'Submitted work will appear here.',
                    onSubmitted: _onSubmitted,
                    onTap: _openDetail,
                  ),
                  _AssignmentList(
                    items: _graded,
                    emptyMessage: 'No grades yet',
                    emptySubtitle: 'Your marks will appear here once graded.',
                    onSubmitted: _onSubmitted,
                    onTap: _openDetail,
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

// ── Summary card ───────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.average,
    required this.graded,
    required this.pending,
    required this.submitted,
  });

  final double average;
  final int graded;
  final int pending;
  final int submitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryDiagonal,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Average Score',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${average.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$graded assignment${graded == 1 ? '' : 's'} graded',
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _StatPill(
                label: 'Pending',
                count: pending,
                color: const Color(0xFFFFD166),
              ),
              const SizedBox(height: 8),
              _StatPill(
                label: 'Submitted',
                count: submitted,
                color: const Color(0xFF90E0EF),
              ),
              const SizedBox(height: 8),
              _StatPill(
                label: 'Graded',
                count: graded,
                color: const Color(0xFF06D6A0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.label,
    required this.count,
    required this.color,
  });
  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$count $label',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab bar ────────────────────────────────────────────────────────────────────

class _AssessmentTabBar extends StatelessWidget {
  const _AssessmentTabBar({required this.controller});
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          gradient: AppGradients.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.textLight,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.all(4),
        tabs: const [
          Tab(text: 'Pending'),
          Tab(text: 'Submitted'),
          Tab(text: 'Graded'),
        ],
      ),
    );
  }
}

// ── Assignment list ────────────────────────────────────────────────────────────

class _AssignmentList extends StatelessWidget {
  const _AssignmentList({
    required this.items,
    required this.emptyMessage,
    required this.emptySubtitle,
    required this.onSubmitted,
    required this.onTap,
  });

  final List<Assignment> items;
  final String emptyMessage;
  final String emptySubtitle;
  final void Function(Assignment, String) onSubmitted;
  final void Function(Assignment) onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 56,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 12),
            Text(emptyMessage, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(emptySubtitle, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, i) => _AssignmentCard(
        item: items[i],
        onSubmitted: onSubmitted,
        onTap: onTap,
      ),
    );
  }
}

// ── Assignment card ────────────────────────────────────────────────────────────

class _AssignmentCard extends StatelessWidget {
  const _AssignmentCard({
    required this.item,
    required this.onSubmitted,
    required this.onTap,
  });

  final Assignment item;
  final void Function(Assignment, String) onSubmitted;
  final void Function(Assignment) onTap;

  Color get _statusColor {
    switch (item.status) {
      case AssignmentStatus.pending:
        return const Color(0xFFFFD166);
      case AssignmentStatus.submitted:
        return const Color(0xFF90E0EF);
      case AssignmentStatus.graded:
        return const Color(0xFF06D6A0);
    }
  }

  String get _statusLabel {
    switch (item.status) {
      case AssignmentStatus.pending:
        return 'Pending';
      case AssignmentStatus.submitted:
        return 'Submitted';
      case AssignmentStatus.graded:
        return 'Graded';
    }
  }

  int get _daysLeft => item.deadline.difference(DateTime.now()).inDays;

  String get _deadlineLabel {
    final d = _daysLeft;
    if (d < 0) return 'Overdue by ${d.abs()} day${d.abs() == 1 ? '' : 's'}';
    if (d == 0) return 'Due today';
    if (d == 1) return '1 day left';
    return '$d days left';
  }

  Color get _deadlineColor {
    final d = _daysLeft;
    if (d < 0) return const Color(0xFFEF476F);
    if (d <= 1) return const Color(0xFFFFD166);
    return const Color(0xFF06D6A0);
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

  void _showSubmitDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _SubmitBottomSheet(
        assignment: item,
        deadlineLabel: _deadlineLabel,
        deadlineColor: _deadlineColor,
        onConfirm: (link) => onSubmitted(item, link),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subject,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (item.status == AssignmentStatus.graded &&
                          item.score != null) ...[
                        Text(
                          '${item.score}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '/ ${item.totalMarks}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
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
                    ],
                  ),
                ],
              ),
            ),

            // ── Deadline row ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 11,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Deadline: ${item.dueDate}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (item.status == AssignmentStatus.pending)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _deadlineColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 10,
                            color: _deadlineColor,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            _deadlineLabel,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _deadlineColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // ── Submitted on (graded only) ────────────────────────────────
            if (item.status == AssignmentStatus.graded &&
                item.submittedAt != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 11,
                      color: Color(0xFF06D6A0),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Submitted: ${_formatDate(item.submittedAt!)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF06D6A0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // ── Divider ───────────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Divider(color: AppColors.divider, height: 1),
            ),

            // ── Instructions ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 13,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Text(
                item.instructions,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textLight,
                  height: 1.5,
                ),
              ),
            ),

            // ── Submitted link ────────────────────────────────────────────
            if (item.status == AssignmentStatus.submitted &&
                item.submittedLink != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF90E0EF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF90E0EF).withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.link_rounded,
                        size: 14,
                        color: Color(0xFF0096B4),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.submittedLink!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF0096B4),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // ── Tap hint + submit button ──────────────────────────────────
            if (item.status == AssignmentStatus.pending)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Row(
                  children: [
                    // Tap to view details hint
                    Row(
                      children: [
                        Icon(
                          Icons.touch_app_rounded,
                          size: 13,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Tap card for details',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Submit button
                    GestureDetector(
                      onTap: () => _showSubmitDialog(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppGradients.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.upload_rounded,
                              size: 14,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Submit',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: Row(
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 13,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Tap for full details',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textLight,
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

// ── Submit bottom sheet ────────────────────────────────────────────────────────

class _SubmitBottomSheet extends StatefulWidget {
  const _SubmitBottomSheet({
    required this.assignment,
    required this.deadlineLabel,
    required this.deadlineColor,
    required this.onConfirm,
  });

  final Assignment assignment;
  final String deadlineLabel;
  final Color deadlineColor;
  final void Function(String link) onConfirm;

  @override
  State<_SubmitBottomSheet> createState() => _SubmitBottomSheetState();
}

class _SubmitBottomSheetState extends State<_SubmitBottomSheet> {
  final _linkController = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  void _confirm() {
    final link = _linkController.text.trim();
    if (!_isValidUrl(link)) {
      setState(() => _hasError = true);
      return;
    }
    Navigator.pop(context);
    widget.onConfirm(link);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Assignment submitted successfully!',
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF06D6A0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Submit Assignment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.assignment.title,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: widget.deadlineColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.deadlineColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: widget.deadlineColor,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deadline',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: widget.deadlineColor.withValues(alpha: 0.8),
                      ),
                    ),
                    Text(
                      '${widget.assignment.dueDate}  ·  ${widget.deadlineLabel}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: widget.deadlineColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Paste your work link',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Share a Google Drive, GitHub, or any public link to your work.',
            style: TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _linkController,
            keyboardType: TextInputType.url,
            onChanged: (_) {
              if (_hasError) setState(() => _hasError = false);
            },
            decoration: InputDecoration(
              hintText: 'https://drive.google.com/...',
              hintStyle: const TextStyle(
                color: AppColors.textLight,
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.link_rounded,
                color: AppColors.primary,
                size: 18,
              ),
              filled: true,
              fillColor: AppColors.background,
              errorText: _hasError ? 'Please enter a valid URL' : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFEF476F)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.divider),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: _confirm,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
