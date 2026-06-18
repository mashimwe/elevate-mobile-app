import 'package:era92_elevate/componets/my_button.dart';
import 'package:era92_elevate/componets/text_field.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/student_shell.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
    final heroHeight = MediaQuery.sizeOf(context).height * 0.52;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        // StackFit.expand forces the Stack to fill the Scaffold body,
        // so Positioned(bottom: 0) resolves against the full screen height.
        fit: StackFit.expand,
        children: [
          // White base — non-positioned, fills the Stack via StackFit.expand
          const ColoredBox(color: AppColors.white),

          // ── Image collage ───────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 6, child: _img(_images[0])),
                      const SizedBox(height: 4),
                      Expanded(flex: 4, child: _img(_images[1])),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 4, child: _img(_images[2])),
                      const SizedBox(height: 4),
                      Expanded(flex: 6, child: _img(_images[3])),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 7, child: _img(_images[4])),
                      const SizedBox(height: 4),
                      Expanded(flex: 3, child: _img(_images[5])),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Gradient overlay ────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.50),
                    AppColors.primary.withValues(alpha: 0.22),
                    Colors.black.withValues(alpha: 0.72),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // ── Brand content ───────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroHeight,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 14, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      child: const Text(
                        'ERA92',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'era92elevate',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                        letterSpacing: -2.0,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Learning portal',
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: 0.75),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // ── Form card ───────────────────────────────────────────
          Positioned(
            top: heroHeight - 28,
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sign in to continue',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    const SizedBox(height: 28),
                    MyTextfield(
                      label: 'Email',
                      icon: Icons.alternate_email,
                      obscuretext: false,
                    ),
                    const SizedBox(height: 14),
                    MyTextfield(
                      label: 'Password',
                      icon: Icons.lock_outline_rounded,
                      obscuretext: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    MyButton(
                      text: 'Sign In',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StudentShell()),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _img(String path) => Image.asset(path, fit: BoxFit.cover);
}
