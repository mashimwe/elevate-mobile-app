import 'package:era92_elevate/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TodaysClassCard extends StatelessWidget {
  const TodaysClassCard({
    super.key,
    required this.subjectName,
    required this.teacherName,
    required this.startTime,
    required this.endTime,
    this.isLive = false,
    this.icon = Icons.menu_book_rounded,
    this.onJoin,
  });

  final String subjectName;
  final String teacherName;
  final String startTime;
  final String endTime;
  final bool isLive;
  final IconData icon;
  final VoidCallback? onJoin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 228,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient header
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppGradients.primaryDiagonal,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                // Decorative circle
                Positioned(
                  right: -18,
                  top: -18,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withValues(alpha: 0.10),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: -10,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white.withValues(alpha: 0.10),
                    ),
                  ),
                ),
                // Icon
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppColors.white, size: 22),
                  ),
                ),
                // Live badge
                if (isLive)
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              // color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Live',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subjectName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          teacherName,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$startTime – $endTime',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: isLive
                        ? GestureDetector(
                            onTap: onJoin,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                gradient: AppGradients.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                'Join Now',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Upcoming',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
