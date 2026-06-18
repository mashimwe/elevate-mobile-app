import 'package:flutter/material.dart';
import 'package:era92_elevate/theme/app_theme.dart';

class ChartRow extends StatelessWidget {
  final String initials;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  const ChartRow({super.key, 
  required this.initials, 
  required this.name, 
  required this.lastMessage, 
  required this.time, 
  required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( 
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar( 
              backgroundColor: AppColors.primary,
              child: Text( 
                initials,
                style: TextStyle(
                  fontFamily: 'Instrument',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 15), 
            Expanded(
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Instrument',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 19, 19, 19),
                    ),
                  ),
                  const SizedBox(height: 0),
                  Text(
                    lastMessage,
                    style: TextStyle(
                      fontFamily: 'Instrument',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 19, 19, 19).withValues(alpha: 150),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontFamily: 'Instrument',
                    fontSize: 10,
                    color: const Color.fromARGB(255, 19, 19, 19).withValues(alpha: 150),
                  ),
                ),
                const SizedBox(height: 4),
                if (unreadCount > 0)
                  CircleAvatar( 
                    radius: 10,
                    backgroundColor: AppColors.primary,
                    child: Text( 
                      unreadCount.toString(),
                      style: TextStyle(
                        fontFamily: 'Instrument',
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Divider(
          color: AppColors.textSecondary.withValues(alpha: 150),
          thickness: 0.5,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}