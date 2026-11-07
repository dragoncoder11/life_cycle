import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/home/view/widgets/prayer_item.dart';
import 'package:life_cycle/features/home/view/widgets/prayer_list.dart';

class PrayerTimesTodayCard extends StatelessWidget {
  const PrayerTimesTodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: isDark?AppColors.notificationCard: AppColors.whiteColor,
          border: Border.all(color: Colors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:isDark?AppColors.whiteColor.withValues(alpha: 0.08): AppColors.blackColor.withValues(alpha: 0.08),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.kPrimaryColor,
                      ),
                      horizontalSpace(8),
                      Text(
                        'Prayer Times Today',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18.sp)
                      ),
                    ],
                  ),
                  Text(
                    'Nov 3,2026',
                    style: AppTextStyles.interGrey(14, FontWeight.w500),
                  ),
                ],
              ),
              verticalSpace(6),
              // SizedBox(height: 80.h,
              //   child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: prayers.length,scrollDirection: Axis.horizontal,itemBuilder: (context,index){
              //   return PrayerItem(prayerModel: prayers[index]);
              //   }),
              // )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrayerItem(prayerModel: prayers[0]),
                  PrayerItem(prayerModel: prayers[1]),
                  PrayerItem(prayerModel: prayers[2]),
                  PrayerItem(prayerModel: prayers[3]),
                  PrayerItem(prayerModel: prayers[4]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
