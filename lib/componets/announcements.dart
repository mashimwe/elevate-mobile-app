import 'dart:async';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class _Announcement {
  const _Announcement({
    required this.title,
    required this.message,
    required this.image,
  });
  final String title;
  final String message;
  final String image;
}

const _announcements = [
  _Announcement(
    title: 'Class & Assessment Reminders',
    message:
        'Stay on top of your schedule. Upcoming classes and exam dates are highlighted in your dashboard to help you plan ahead.',
    image: 'assets/elevate-1.jpg',
  ),
  _Announcement(
    title: 'Be Part of the Community',
    message:
        'Connect, grow, and thrive together. Elevate is more than a school — it\'s a movement.',
    image: 'assets/elevate-2.jpg',
  ),
  _Announcement(
    title: 'Attendance Registration Required',
    message:
        'You are required to register your attendance for every class. Use the Check-In feature before or during each session to stay compliant.',
    image: 'assets/elevate-3.jpg',
  ),
];

class AnnouncementBanner extends StatefulWidget {
  const AnnouncementBanner({super.key});

  @override
  State<AnnouncementBanner> createState() => _AnnouncementBannerState();
}

class _AnnouncementBannerState extends State<AnnouncementBanner> {
  final _controller = PageController();
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final next = (_current + 1) % _announcements.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _controller,
            itemCount: _announcements.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, index) {
              final a = _announcements[index];
              return _AnnouncementCard(announcement: a);
            },
          ),
        ),
        const SizedBox(height: 10),
        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_announcements.length, (i) {
            final isActive = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.divider,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.announcement});
  final _Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(announcement.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Dark gradient overlay so text is always readable over the photo
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black.withValues(alpha: 0.20),
                Colors.black.withValues(alpha: 0.82),
              ],
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                announcement.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                announcement.message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white.withValues(alpha: 0.90),
                      height: 1.4,
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
