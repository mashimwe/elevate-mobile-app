import 'package:era92_elevate/models/assessment.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ── Detail screen ──────────────────────────────────────────────────────────────

class AssignmentDetailScreen extends StatelessWidget {
  const AssignmentDetailScreen({super.key, required this.assignment});

  final Assignment assignment;

  // ── Helpers ────────────────────────────────────────────────────────────────

  Color get _statusColor {
    switch (assignment.status) {
      case AssignmentStatus.pending:
        return const Color(0xFFFFD166);
      case AssignmentStatus.submitted:
        return const Color(0xFF90E0EF);
      case AssignmentStatus.graded:
        return const Color(0xFF06D6A0);
    }
  }

  String get _statusLabel {
    switch (assignment.status) {
      case AssignmentStatus.pending:
        return 'Pending';
      case AssignmentStatus.submitted:
        return 'Submitted';
      case AssignmentStatus.graded:
        return 'Graded';
    }
  }

  int get _daysLeft => assignment.deadline.difference(DateTime.now()).inDays;

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

  String _formatDateTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
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
    return '${months[dt.month]} ${dt.day}, ${dt.year}  ·  $hour:$minute $period';
  }

  double get _scorePercent =>
      assignment.score != null ? assignment.score! / assignment.totalMarks : 0;

  Color get _scoreColor {
    if (_scorePercent >= 0.75) return const Color(0xFF06D6A0);
    if (_scorePercent >= 0.50) return const Color(0xFFFFD166);
    return const Color(0xFFEF476F);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Gradient app bar ─────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryDiagonal,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Subject chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                assignment.icon,
                                size: 12,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                assignment.subject,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          assignment.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Body ─────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Status row ─────────────────────────────────────────
                  Row(
                    children: [
                      _StatusBadge(label: _statusLabel, color: _statusColor),
                      const SizedBox(width: 10),
                      if (assignment.status == AssignmentStatus.pending)
                        _StatusBadge(
                          label: _deadlineLabel,
                          color: _deadlineColor,
                          icon: Icons.access_time_rounded,
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Score card (graded only) ───────────────────────────
                  if (assignment.status == AssignmentStatus.graded &&
                      assignment.score != null) ...[
                    _ScoreCard(
                      score: assignment.score!,
                      total: assignment.totalMarks,
                      percent: _scorePercent,
                      color: _scoreColor,
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Info rows ──────────────────────────────────────────
                  _InfoCard(
                    children: [
                      _InfoRow(
                        icon: Icons.calendar_today_rounded,
                        label: 'Deadline',
                        value: assignment.dueDate,
                      ),
                      if (assignment.submittedAt != null) ...[
                        const _InfoDivider(),
                        _InfoRow(
                          icon: Icons.check_circle_rounded,
                          label: 'Submitted on',
                          value: _formatDateTime(assignment.submittedAt!),
                          valueColor: const Color(0xFF06D6A0),
                        ),
                      ],
                      if (assignment.submittedLink != null) ...[
                        const _InfoDivider(),
                        _InfoRow(
                          icon: Icons.link_rounded,
                          label: 'Work link',
                          value: assignment.submittedLink!,
                          valueColor: AppColors.primary,
                          isLink: true,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Instructions ───────────────────────────────────────
                  _SectionLabel(
                    icon: Icons.info_outline_rounded,
                    label: 'Instructions',
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      assignment.instructions,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textLight,
                        height: 1.7,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Submission timeline ────────────────────────────────
                  _SectionLabel(
                    icon: Icons.timeline_rounded,
                    label: 'Timeline',
                  ),
                  const SizedBox(height: 10),
                  _TimelineCard(assignment: assignment),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Score card ─────────────────────────────────────────────────────────────────

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({
    required this.score,
    required this.total,
    required this.percent,
    required this.color,
  });

  final int score;
  final int total;
  final double percent;
  final Color color;

  String get _grade {
    if (percent >= 0.90) return 'A';
    if (percent >= 0.80) return 'B';
    if (percent >= 0.70) return 'C';
    if (percent >= 0.60) return 'D';
    return 'F';
  }

  String get _feedback {
    if (percent >= 0.90) return 'Outstanding work!';
    if (percent >= 0.80) return 'Great job!';
    if (percent >= 0.70) return 'Good effort.';
    if (percent >= 0.60) return 'Needs improvement.';
    return 'Please see your lecturer.';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.primaryDiagonal,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Score number
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Score',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$score',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                      TextSpan(
                        text: ' / $total',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percent,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _feedback,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Grade circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _grade,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info card ──────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.isLink = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? AppColors.textPrimary,
                    decoration: isLink ? TextDecoration.underline : null,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.divider, height: 1, indent: 60);
  }
}

// ── Timeline card ──────────────────────────────────────────────────────────────

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.assignment});
  final Assignment assignment;

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
    return '${months[dt.month]} ${dt.day}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final steps = <_TimelineStep>[
      _TimelineStep(
        label: 'Assignment Posted',
        subtitle: 'Available in your assessments',
        icon: Icons.assignment_rounded,
        color: AppColors.primary,
        done: true,
      ),
      _TimelineStep(
        label: 'Deadline',
        subtitle: assignment.dueDate,
        icon: Icons.calendar_today_rounded,
        color: const Color(0xFFFFD166),
        done: assignment.status != AssignmentStatus.pending,
      ),
      _TimelineStep(
        label: 'Submitted',
        subtitle: assignment.submittedAt != null
            ? _formatDate(assignment.submittedAt!)
            : 'Not yet submitted',
        icon: Icons.upload_rounded,
        color: const Color(0xFF90E0EF),
        done:
            assignment.status == AssignmentStatus.submitted ||
            assignment.status == AssignmentStatus.graded,
      ),
      _TimelineStep(
        label: 'Graded',
        subtitle: assignment.status == AssignmentStatus.graded
            ? 'Score: ${assignment.score} / ${assignment.totalMarks}'
            : 'Awaiting grade',
        icon: Icons.star_rounded,
        color: const Color(0xFF06D6A0),
        done: assignment.status == AssignmentStatus.graded,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(steps.length, (i) {
          final step = steps[i];
          final isLast = i == steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: icon + line
              Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: step.done
                          ? step.color.withValues(alpha: 0.15)
                          : AppColors.divider.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      step.done ? step.icon : Icons.radio_button_unchecked,
                      size: 18,
                      color: step.done ? step.color : AppColors.textLight,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 32,
                      color: step.done
                          ? step.color.withValues(alpha: 0.3)
                          : AppColors.divider,
                    ),
                ],
              ),
              const SizedBox(width: 14),
              // Right: text
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 18, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: step.done
                              ? AppColors.textPrimary
                              : AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        step.subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _TimelineStep {
  const _TimelineStep({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.done,
  });
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool done;
}

// ── Small helpers ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.color, this.icon});
  final String label;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
