import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';
import 'package:life_cycle/features/prayer/views/widgets/prayer_item.dart';

class PrayerTimeCard extends StatelessWidget {
  const PrayerTimeCard({
    super.key,
    required this.isDark,
    required this.prayerTimes,
    required this.state,
    this.isLoading = false,
  });

  final bool isDark;
  final PrayerTimesModel prayerTimes;
  final PrayerLoaded state;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.notificationCard
              : AppColors.whiteColor,
          border: Border.all(
            color: Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppColors.whiteColor.withValues(alpha: 0.08)
                  : AppColors.blackColor.withValues(alpha: 0.08),
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
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: AppColors.kPrimaryColor,
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      'Prayer Times Today',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 18.sp),
                    ),
                  ),
                  Text(
                    prayerTimes.date,
                    style: AppTextStyles.interGrey(
                      14,
                      FontWeight.w500,
                    ),
                  ),
                ],
              ),

              verticalSpace(6),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrayerItem(
                    icon: Icons.wb_twilight,
                    iconColor: AppColors.blueColor,
                    prayerName: 'Fajr',
                    prayerTime: prayerTimes.fajrTime,
                    isNextPrayer: !isLoading &&
                        state.nextPrayer == 'Fajr',
                    isLoading: isLoading,
                  ),

                  PrayerItem(
                    icon: Icons.wb_sunny_rounded,
                    iconColor: AppColors.accent,
                    prayerName: 'Dhuhr',
                    prayerTime: prayerTimes.dhuhrTime,
                    isNextPrayer: !isLoading &&
                        state.nextPrayer == 'Dhuhr',
                    isLoading: isLoading,
                  ),

                  PrayerItem(
                    icon: Icons.sunny,
                    iconColor: AppColors.kPrimaryColor,
                    prayerName: 'Asr',
                    prayerTime: prayerTimes.asrTime,
                    isNextPrayer: !isLoading &&
                        state.nextPrayer == 'Asr',
                    isLoading: isLoading,
                  ),PrayerItem(
                    icon: Icons.wb_twilight,
                    iconColor: AppColors.financeYellow,
                    prayerName: 'Maghrib',
                    prayerTime: prayerTimes.maghribTime,
                    isNextPrayer: !isLoading &&
                        state.nextPrayer == 'Maghrib',
                    isLoading: isLoading,
                  ),

                  PrayerItem(
                    icon: Icons.bedtime,
                    iconColor: AppColors.blueColor,
                    prayerName: 'Isha',
                    prayerTime: prayerTimes.ishaTime,
                    isNextPrayer: !isLoading &&
                        state.nextPrayer == 'Isha',
                    isLoading: isLoading,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}