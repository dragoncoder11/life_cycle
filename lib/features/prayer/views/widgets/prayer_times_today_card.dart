import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';
import 'package:life_cycle/features/prayer/views/widgets/prayer_item.dart';

class PrayerTimesTodayCard extends StatelessWidget {
  const PrayerTimesTodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading) {
          return Expanded(
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.kPrimaryColor),
            ),
          );
        }

        if (state is PrayerFailure) {
          return Center(child: Text(state.errMessage));
        }

        if (state is PrayerSuccess) {
          final prayerTimes = state.prayerTimes;

          return Card(
            elevation: 3,
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.notificationCard
                    : AppColors.whiteColor,
                border: Border.all(color: Colors.transparent, width: 1.5),
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
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(fontSize: 18.sp),
                            ),
                          ],
                        ),
                        Text(
                          prayerTimes.date,
                          style: AppTextStyles.interGrey(14, FontWeight.w500),
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
                          isNextPrayer: state.nextPrayerName == 'Fajr',
                        ),
                        PrayerItem(
                          icon: Icons.wb_sunny_rounded,
                          iconColor: AppColors.accent,
                          prayerName: 'Dhuhr',
                          prayerTime: prayerTimes.dhuhrTime,
                          isNextPrayer: state.nextPrayerName == 'Dhuhr',
                        ),
                        PrayerItem(
                          icon: Icons.sunny,
                          iconColor: AppColors.kPrimaryColor,
                          prayerName: 'Asr',
                          prayerTime: prayerTimes.asrTime,
                          isNextPrayer: state.nextPrayerName == 'Asr',
                        ),
                        PrayerItem(
                          icon: Icons.wb_twilight,
                          iconColor: AppColors.financeYellow,
                          prayerName: 'Maghrib',
                          prayerTime: prayerTimes.maghribTime,
                          isNextPrayer: state.nextPrayerName == 'Maghrib',
                        ),
                        PrayerItem(
                          icon: Icons.bedtime,
                          iconColor: AppColors.blueColor,
                          prayerName: 'Isha',
                          prayerTime: prayerTimes.ishaTime,
                          isNextPrayer: state.nextPrayerName == 'Isha',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
