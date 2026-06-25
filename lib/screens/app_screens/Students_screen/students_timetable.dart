import 'dart:math';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

// ── Data models ────────────────────────────────────────────────────────────────

class _DayData {
  const _DayData({
    required this.num,
    required this.name,
    required this.fullName,
    required this.isToday,
    required this.dayIndex,
  });
  final String num;
  final String name;
  final String fullName;
  final bool isToday;
  final int dayIndex;
}

class _Lesson {
  const _Lesson({
    required this.subject,
    required this.time,
    required this.instructor,
    required this.description,
    this.isOngoing = false,
  });
  final String subject;
  final String time;
  final String instructor;
  final String description;
  final bool isOngoing;
}

// ── Static data ────────────────────────────────────────────────────────────────

const _weekDays = [
  _DayData(num: '10', name: 'Mon', fullName: 'Monday', isToday: false, dayIndex: 0),
  _DayData(num: '11', name: 'Tue', fullName: 'Tuesday', isToday: false, dayIndex: 1),
  _DayData(num: '12', name: 'Wed', fullName: 'Wednesday', isToday: false, dayIndex: 2),
  _DayData(num: '13', name: 'Thu', fullName: 'Thursday', isToday: true, dayIndex: 3),
  _DayData(num: '14', name: 'Fri', fullName: 'Friday', isToday: false, dayIndex: 4),
  _DayData(num: '15', name: 'Sat', fullName: 'Saturday', isToday: false, dayIndex: 5),
  _DayData(num: '16', name: 'Sun', fullName: 'Sunday', isToday: false, dayIndex: 6),
];

const _allSubjects = [
  {'subject': 'Graphics Design', 'instructor': 'Dr. Smith', 'time': '08:00 – 09:30', 'desc': 'Layout & Hierarchy'},
  {'subject': 'Web Development', 'instructor': 'Prof. Johnson', 'time': '10:00 – 11:30', 'desc': 'Introduction to Web'},
  {'subject': 'Motion Graphics', 'instructor': 'Dr. Lee', 'time': '12:00 – 13:30', 'desc': 'Fundamentals of Motion'},
  {'subject': 'UI/UX Design', 'instructor': 'Ms. Nakato', 'time': '14:00 – 15:30', 'desc': 'User Research & Wireframing'},
  {'subject': 'Photography', 'instructor': 'Mr. Okello', 'time': '08:00 – 09:30', 'desc': 'Composition & Lighting'},
  {'subject': 'Brand Identity', 'instructor': 'Mr. Mugisha', 'time': '10:00 – 11:30', 'desc': 'Logo Design & Brand Systems'},
  {'subject': 'Typography', 'instructor': 'Dr. Apio', 'time': '12:00 – 13:30', 'desc': 'Type Hierarchy & Pairing'},
];

List<_Lesson> _lessonsForDay(int dayIndex) {
  if (dayIndex == 6) return []; // Sunday — no classes
  final pool = List<Map<String, String>>.from(_allSubjects.cast<Map<String, String>>());
  pool.shuffle(Random(dayIndex));
  final count = dayIndex == 5 ? 1 : 3;
  return List.generate(count, (i) {
    final s = pool[i];
    return _Lesson(
      subject: s['subject']!,
      time: s['time']!,
      instructor: s['instructor']!,
      description: s['desc']!,
      isOngoing: dayIndex == 3 && i == 1, // Thursday, second class is ongoing
    );
  });
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class StudentsTimetable extends StatefulWidget {
  const StudentsTimetable({super.key});

  @override
  State<StudentsTimetable> createState() => _StudentsTimetableState();
}

class _StudentsTimetableState extends State<StudentsTimetable> {
  late int _selectedDay;
  late final ScrollController _dayStripController;

  @override
  void initState() {
    super.initState();
    _selectedDay = _weekDays.indexWhere((d) => d.isToday);
    if (_selectedDay < 0) _selectedDay = 0;
    _dayStripController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollDayIntoView());
  }

  @override
  void dispose() {
    _dayStripController.dispose();
    super.dispose();
  }

  void _scrollDayIntoView() {
    const itemWidth = 54.0;
    const padding = 20.0;
    final offset = (_selectedDay * itemWidth) - padding;
    if (_dayStripController.hasClients) {
      _dayStripController.animateTo(
        offset.clamp(0.0, _dayStripController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final day = _weekDays[_selectedDay];
    final lessons = _lessonsForDay(_selectedDay);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedule',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'June 2025',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Week 2',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Day strip ────────────────────────────────────────────────────
            SizedBox(
              height: 70,
              child: ListView.builder(
                controller: _dayStripController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _weekDays.length,
                itemBuilder: (context, i) {
                  final d = _weekDays[i];
                  final isSelected = i == _selectedDay;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedDay = i;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 46,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : d.isToday
                                  ? AppColors.primary.withValues(alpha: 0.3)
                                  : AppColors.border,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            d.name,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.white.withValues(alpha: 0.85)
                                  : AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            d.num,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                          if (d.isToday && !isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // ── Selected day label ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    day.fullName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (day.isToday) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    lessons.isEmpty
                        ? 'No classes'
                        : '${lessons.length} class${lessons.length == 1 ? '' : 'es'}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Lesson list ──────────────────────────────────────────────────
            Expanded(
              child: lessons.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceWarm,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.wb_sunny_outlined,
                              size: 30,
                              color: AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'No classes today',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Enjoy your day off!',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: lessons.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _LessonCard(
                        lesson: lessons[i],
                        number: i + 1,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Lesson card ────────────────────────────────────────────────────────────────

class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson, required this.number});
  final _Lesson lesson;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: lesson.isOngoing
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.border,
          width: lesson.isOngoing ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // ── Left accent bar (ongoing only) + number ──────────────────────
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: lesson.isOngoing
                  ? AppColors.primary.withValues(alpha: 0.06)
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$number',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: lesson.isOngoing
                        ? AppColors.primary
                        : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, color: AppColors.divider),

          // ── Content ──────────────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          lesson.time,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      if (lesson.isOngoing) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 6,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Ongoing',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.subject,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 12,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lesson.instructor,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.book_outlined,
                        size: 12,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          lesson.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (lesson.isOngoing) ...[
                    const SizedBox(height: 10),
                    GestureDetector(
                      child: Row(
                        children: [
                          Text(
                            'Join live class',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 12,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
