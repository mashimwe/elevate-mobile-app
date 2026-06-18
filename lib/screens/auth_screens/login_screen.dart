import 'package:era92_elevate/componets/text_field.dart';
import 'package:era92_elevate/componets/my_button.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextfield(label: 'Enter email', icon: Icons.email),
            const SizedBox(height: 20),
            MyTextfield(label: 'Enter password', icon: Icons.lock),
            const SizedBox(height: 20),
            Text("data", style: TextStyle(color: AppColors.primary),)
          ],
        ),
      ),
    );
  }
}
