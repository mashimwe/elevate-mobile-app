import 'package:era92_elevate/componets/my_button.dart';
import 'package:era92_elevate/componets/text_field.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/student_shell.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Local images reused across the 6 grid slots
  static const _images = [
    'assets/elevate-1.jpg',
    'assets/elevate-3.jpg',
    'assets/elevate-2.jpg',
    'assets/elevate-3.jpg',
    'assets/elevate-1.jpg',
    'assets/elevate-2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Photo grid with fade-out at bottom
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
                  child: SizedBox(
                    height: 300,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _gridImage(_images[0], height: 160),
                              const SizedBox(height: 4),
                              _gridImage(_images[1], height: 136),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            children: [
                              _gridImage(_images[2], height: 120),
                              const SizedBox(height: 4),
                              _gridImage(_images[3], height: 176),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            children: [
                              _gridImage(_images[4], height: 180),
                              const SizedBox(height: 4),
                              _gridImage(_images[5], height: 116),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Fade overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withValues(alpha: 0),
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    'Era92 Elevate',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 32),
                  MyTextfield(
                    label: 'Email',
                    icon: Icons.alternate_email,
                    obscuretext: false,
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    label: 'Password',
                    icon: Icons.lock_outline_rounded,
                    obscuretext: true,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  MyButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StudentShell(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gridImage(String path, {required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
