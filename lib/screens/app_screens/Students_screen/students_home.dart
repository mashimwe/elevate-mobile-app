import 'package:era92_elevate/componets/announcements.dart';
import 'package:era92_elevate/componets/todays_class_card.dart';
import 'package:flutter/material.dart';
import 'package:era92_elevate/theme/app_theme.dart';

// Sample model — replace with real data when backend is ready
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

class StudentsHome extends StatelessWidget {
  const StudentsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                      backgroundColor:
                          AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.person_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Announcement banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnnouncementBanner(),
              ),
              const SizedBox(height: 28),

              // Section header
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

              // Horizontally scrollable cards
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
