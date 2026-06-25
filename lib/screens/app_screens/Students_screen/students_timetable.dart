import 'package:flutter/material.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:era92_elevate/componets/day_card.dart';

class StudentsTimetable extends StatefulWidget {
  const StudentsTimetable({super.key});

  @override
  State<StudentsTimetable> createState() => _StudentsTimetableState();
}

class _StudentsTimetableState extends State<StudentsTimetable> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> weekDays = [
    {'num': '10', 'name': 'Mon', 'isToday': false, 'currentLessonIndex': 0},
    {'num': '11', 'name': 'Tue', 'isToday': false, 'currentLessonIndex': 0},
    {'num': '12', 'name': 'Wed', 'isToday': false, 'currentLessonIndex': 0},
    {'num': '13', 'name': 'Thu', 'isToday': true,  'currentLessonIndex': 1},
    {'num': '14', 'name': 'Fri', 'isToday': false, 'currentLessonIndex': 0},
    {'num': '15', 'name': 'Sat', 'isToday': false, 'currentLessonIndex': 0},
    {'num': '16', 'name': 'Sun', 'isToday': false, 'currentLessonIndex': 0},
  ];

  int get todayIndex =>
      weekDays.indexWhere((day) => day['isToday'] == true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const estimatedCardHeight = 290.0;
      const previousDayPeek = 50.0;
      final offset = ((todayIndex - 1) * estimatedCardHeight) - previousDayPeek;
      _scrollController.jumpTo(offset < 0 ? 0 : offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Timetable',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Your weekly class schedule',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // ── Date strip ──
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(weekDays.length, (i) {
                    final isSelected = weekDays[i]['isToday'] as bool;

                    return Container(
                      width: 36,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? AppGradients.primary
                            : LinearGradient(colors: [
                                AppColors.background,
                                AppColors.background,
                              ]),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weekDays[i]['num'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            weekDays[i]['name'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: weekDays.length,
                  itemBuilder: (context, index) {
                    final day = weekDays[index];
                    return DayCard(
                      dayName: day['name'],
                      isToday: day['isToday'],
                      currentLessonIndex: day['currentLessonIndex'],
                      isFirst: index == 0,
                      isLast: index == weekDays.length - 1,
                      dayIndex: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}