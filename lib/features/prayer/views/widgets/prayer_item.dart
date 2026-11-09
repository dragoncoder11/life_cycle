import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({super.key,required this.icon,required this.iconColor, required this.prayerName, required this.prayerTime, this.isNextPrayer=false, });
  final IconData icon;
  final Color iconColor;
  final String prayerName;
  final String prayerTime;
  final bool isNextPrayer;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 70.h,
      width: mediaQueryWidth * .16,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:isNextPrayer?AppColors.kPrimaryColor.withOpacity(.3): isDark?AppColors.notificationCard.withOpacity(.7): AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 24,
            color: iconColor,
          ),
          Text(
            prayerName,
            style: Theme.of(context).textTheme.displayLarge
                ?.copyWith(fontSize: 10.sp)
                .copyWith(
                  color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                ),
          ),
          Text(
            prayerTime,
            style: Theme.of(context).textTheme.displayLarge
                ?.copyWith(fontSize: 11.sp)
                .copyWith(
                  color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                ),
          ),
        ],
      ),
    );
  }
}
