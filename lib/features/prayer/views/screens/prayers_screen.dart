import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/status_bar_mode.dart';
import 'package:life_cycle/features/prayer/data/services/adhan_service.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';
import 'package:life_cycle/features/prayer/logic/prayer_settings_cubit/prayer_settings_cubit.dart';

class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Prayer Times',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),

                verticalSpace(16),

                Expanded(
                  child: BlocBuilder<PrayerCubit, PrayerState>(
                    builder: (context, state) {
                      if (state is PrayerLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kPrimaryColor,
                          ),
                        );
                      }

                      if (state is PrayerFailure) {
                        return Center(child: Text(state.errMessage));
                      }

                      if (state is PrayerLoaded) {
                        final prayerTimes = state.prayerTimes;

                        return ListView(
                          children: [
                            _NextPrayerCard(
                              nextPrayer: state.nextPrayer,
                              nextPrayerTime: state.nextPrayerTime,
                            ),

                            verticalSpace(10),

                            _buildPrayerItem(
                              'Fajr',
                              prayerTimes.fajrTime,
                              'fajrEnabled',
                              context,
                            ),

                            _buildPrayerItem(
                              'Dhuhr',
                              prayerTimes.dhuhrTime,
                              'dhuhrEnabled',
                              context,
                            ),

                            _buildPrayerItem(
                              'Asr',
                              prayerTimes.asrTime,
                              'asrEnabled',
                              context,
                            ),

                            _buildPrayerItem(
                              'Maghrib',
                              prayerTimes.maghribTime,
                              'maghribEnabled',
                              context,
                            ),

                            _buildPrayerItem(
                              'Isha',
                              prayerTimes.ishaTime,
                              'ishaEnabled',
                              context,
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrayerItem(
    String name,
    String time,
    String prayerKey,
    BuildContext context,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<PrayerSettingsCubit, PrayerSettingsState>(
      builder: (context, state) {
        final cubit = context.read<PrayerSettingsCubit>();

        return Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.notificationCard : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12.r),
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                title: Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 15.sp),
                ),
                subtitle: Text(
                  time,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 13.sp),
                ),
                trailing: Switch(
                  value: cubit.isEnabled(prayerKey),
                  activeColor: AppColors.kPrimaryColor,
                  onChanged: (value) async {
                    await cubit.togglePrayer(prayerKey, value);

                    await context.read<PrayerCubit>().refreshAdhanSchedule();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NextPrayerCard extends StatelessWidget {
  final String nextPrayer;
  final DateTime nextPrayerTime;

  const _NextPrayerCard({
    required this.nextPrayer,
    required this.nextPrayerTime,
  });

  String formatRemainingTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Next Prayer',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),

          verticalSpace(6),

          Text(
            nextPrayer,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          verticalSpace(8),

          Text(
            'Remaining: ',
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
          StreamBuilder<int>(
            stream: Stream.periodic(
              const Duration(seconds: 1),
              (count) => count,
            ),
            builder: (context, snapshot) {
              final remaining = nextPrayerTime.difference(DateTime.now());

              return Text(
                formatRemainingTime(
                  remaining.isNegative ? Duration.zero : remaining,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
