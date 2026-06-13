import 'package:flutter/material.dart';
import 'package:era92_elevate/theme/app_theme.dart';

class StudentsTimetable extends StatelessWidget {
  const StudentsTimetable({super.key});

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
              Text('Timetable',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Your weekly class schedule',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Expanded(
                child: Center(
                  child: Icon(Icons.calendar_month_rounded,
                      size: 64, color: AppColors.textLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
