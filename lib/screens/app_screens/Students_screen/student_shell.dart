import 'package:era92_elevate/componets/bottom_nav_bar.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/students_chat.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/students_home.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/students_live_class.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/students_timetable.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/students_assessment.dart';
import 'package:flutter/material.dart';

class StudentShell extends StatefulWidget {
  const StudentShell({super.key});

  @override
  State<StudentShell> createState() => _StudentShellState();
}

class _StudentShellState extends State<StudentShell> {
  int _currentIndex = 0;

  // Order must match AppBottomNavBar items: Home, Live Class, Timetable, Chat
  static const _pages = <Widget>[
    StudentsHome(),
    StudentsLiveClass(),
    StudentsTimetable(),
    StudentsChat(),
    StudentsAssessment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
