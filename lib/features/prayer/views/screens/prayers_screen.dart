import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/status_bar_mode.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';

class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String formatRemainingTime(Duration duration) {
      final hours = duration.inHours.toString().padLeft(2, '0');
      final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
      final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

      return '$hours:$minutes:$seconds';
    }

    return StatusBarMode(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(16),

                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Prayer Times',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                verticalSpace(16),
                BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    if (state is PrayerLoading) {
                      return Expanded(
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      );
                    }

                    if (state is PrayerFailure) {
                      return Center(child: Text(state.errMessage));
                    }

                    if (state is PrayerSuccess) {
                      final prayerTimes = state.prayerTimes;

                      return Expanded(
                        child: ListView(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Next Prayer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  verticalSpace(6),
                                  Text(
                                    state.nextPrayerName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  verticalSpace(6),
                                  Text(
                                    state.nextPrayerTime,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  verticalSpace(8),
                                  Text(
                                    'Remaining: ${formatRemainingTime(state.remainingDuration)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(10),
                            _buildPrayerItem(
                              'Fajr',
                              prayerTimes.fajrTime,
                              context,
                            ),
                            _buildPrayerItem(
                              'Dhuhr',
                              prayerTimes.dhuhrTime,
                              context,
                            ),
                            _buildPrayerItem(
                              'Asr',
                              prayerTimes.asrTime,
                              context,
                            ),
                            _buildPrayerItem(
                              'Maghrib',
                              prayerTimes.maghribTime,
                              context,
                            ),
                            _buildPrayerItem(
                              'Isha',
                              prayerTimes.ishaTime,
                              context,
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerItem(String name, String time, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.notificationCard : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? AppColors.whiteColor.withValues(alpha: 0.08)
                  : AppColors.blackColor.withValues(alpha: 0.08),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: ListTile(
            title: Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontSize: 15.sp),
            ),
            trailing: Text(
              time,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontSize: 13.sp),
            ),
          ),
        ),
      ),
    );
  }
}
