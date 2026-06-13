import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = <TabItem>[
    TabItem(icon: Icons.home_rounded, title: 'Home'),
    TabItem(icon: Icons.play_circle_outline_rounded, title: 'Live Class'),
    TabItem(icon: Icons.calendar_month_rounded, title: 'Timetable'),
    TabItem(icon: Icons.chat_bubble_outline_rounded, title: 'Chat'),
  ];

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.reactCircle,
      items: _items,
      initialActiveIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.white,
      color: AppColors.textSecondary,
      activeColor: AppColors.primary,
      height: 60,
      shadowColor: Colors.black12,
    );
  }
}
