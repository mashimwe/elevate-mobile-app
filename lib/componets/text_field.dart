import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
    final String label;
    final IconData? icon;
  const MyTextfield({super.key, required this.label,  required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}