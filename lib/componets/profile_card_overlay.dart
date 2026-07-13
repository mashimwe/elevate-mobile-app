import 'dart:ui';

import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Call this from the avatar's onTap. It shows the current screen blurred
/// behind a profile card with a logout button.
///
/// Usage:
///   showProfileCard(context, name: 'Student', email: 'student@era92.com');
Future<void> showProfileCard(
  BuildContext context, {
  required String name,
  required String email,
  VoidCallback? onLogout,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Profile',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return _ProfileCardOverlay(
        name: name,
        email: email,
        onLogout: onLogout ??
            () {
              Navigator.of(context).pop();
              // TODO: wire this to your real sign-out flow, e.g.
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (_) => const LoginScreen()),
              //   (route) => false,
              // );
            },
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          alignment: Alignment.topRight,
          scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _ProfileCardOverlay extends StatelessWidget {
  const _ProfileCardOverlay({
    required this.name,
    required this.email,
    required this.onLogout,
  });

  final String name;
  final String email;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withValues(alpha: 0.12),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 64, right: 20),
                  // Swallow taps on the card itself so they don't dismiss it.
                  child: GestureDetector(
                    onTap: () {},
                    child: _ProfileCard(
                      name: name,
                      email: email,
                      onLogout: onLogout,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.name,
    required this.email,
    required this.onLogout,
  });

  final String name;
  final String email;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            email,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 6),
          _ProfileMenuItem(
            icon: Icons.person_outline_rounded,
            label: 'View profile',
            onTap: () => Navigator.of(context).pop(),
          ),
          _ProfileMenuItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: onLogout,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                backgroundColor: AppColors.error.withValues(alpha: 0.08),
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.logout_rounded, size: 17),
              label: const Text(
                'Log out',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}