import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.prayerName,
    required this.prayerTime,
    this.isNextPrayer = false,
    this.isLoading = false,
  });

  final IconData icon;
  final Color iconColor;
  final String prayerName;
  final String prayerTime;
  final bool isNextPrayer;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final greyColor = isDark
        ? Colors.grey.shade800
        : Colors.grey.shade300;

    return Container(
      height: 70.h,
      width: mediaQueryWidth * .16,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isLoading
            ? greyColor
            : isNextPrayer
                ? AppColors.kPrimaryColor.withOpacity(.3)
                : isDark
                    ? AppColors.notificationCard.withOpacity(.7)
                    : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (isLoading) ...[
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 30.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: 35.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ] else ...[
            Icon(icon, size: 24, color: iconColor),
            Text(
              prayerName,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 10.sp,
                    color: isDark
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
            ),
            Text(
              prayerTime,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 11.sp,
                    color: isDark
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}