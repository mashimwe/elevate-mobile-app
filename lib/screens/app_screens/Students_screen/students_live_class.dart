import 'package:flutter/material.dart';
import 'package:era92_elevate/theme/app_theme.dart';

class StudentsLiveClass extends StatelessWidget {
  const StudentsLiveClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Classes'),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Live Classes',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Upcoming & ongoing live sessions',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Expanded(
                child: Center(
                  child: Icon(Icons.play_circle_outline_rounded,
                      size: 64, color: AppColors.textLight),
                ),
              ),
            ],
          ),
        ),
      ),

      // floaring button
      //nav abar

    );
  }
}
