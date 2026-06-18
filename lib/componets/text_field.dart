import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
    final String label;
    final IconData? icon;
    final bool obscuretext;
  const MyTextfield({super.key, required this.label,  required this.icon, required this.obscuretext});

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