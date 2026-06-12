import 'package:flutter/material.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      // body with centered text 'Students Screen'
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Students Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),

     
    );
  }
}
