import 'package:era92_elevate/componets/chat_row.dart';
import 'package:era92_elevate/screens/app_screens/Students_screen/personal_chat_screen.dart';
import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class _Contact {
  const _Contact({
    required this.initials,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = 0,
    this.isOnline = false,
  });

  final String initials;
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final bool isOnline;
}

const _contacts = [
  _Contact(
    initials: 'AB',
    name: 'Alice Brown',
    lastMessage: 'Hurry, he is giving an assignment now',
    time: '10:30 AM',
    unread: 2,
    isOnline: true,
  ),
  _Contact(
    initials: 'CD',
    name: 'Charlie Davis',
    lastMessage: 'What time is class tomorrow?',
    time: '9:15 AM',
    unread: 1,
    isOnline: false,
  ),
  _Contact(
    initials: 'EF',
    name: 'Emily Foster',
    lastMessage: 'Can you share the notes from today?',
    time: 'Yesterday',
    isOnline: true,
  ),
  _Contact(
    initials: 'GH',
    name: 'George Harris',
    lastMessage: 'I am struggling with the homework.',
    time: 'Monday',
  ),
  _Contact(
    initials: 'JK',
    name: 'Jane Kimani',
    lastMessage: 'See you in class!',
    time: 'Sunday',
  ),
];

class StudentsChat extends StatelessWidget {
  const StudentsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Chats',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search_rounded, size: 24),
                    style: IconButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.30),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Search bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Search conversations...',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.textLight,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Chat list ───────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _contacts.length,
                itemBuilder: (context, i) {
                  final c = _contacts[i];
                  return ChatRow(
                    initials: c.initials,
                    name: c.name,
                    lastMessage: c.lastMessage,
                    time: c.time,
                    unreadCount: c.unread,
                    isOnline: c.isOnline,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PersonalChatScreen(
                          initials: c.initials,
                          name: c.name,
                          isOnline: c.isOnline,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
