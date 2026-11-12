import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/prayer/data/models/prayer_times_model.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';
import 'package:life_cycle/features/prayer/views/widgets/prayer_time_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PrayerTimesTodayCard extends StatelessWidget {
  const PrayerTimesTodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final skeletonColor = isDark
        ? AppColors.notificationCard
        : AppColors.whiteColor;

    final highlightColor = isDark
        ? AppColors.notificationCard.withOpacity(0.5)
        : Colors.grey.shade200;

    final dummyPrayerTimes = PrayerTimesModel(
      fajrTime: '05:00',
      dhuhrTime: '12:00',
      asrTime: '03:30',
      maghribTime: '05:45',
      ishaTime: '07:00',
      date: '12 Nov 2026',
      timeZone: 'Africa/Cairo',
    );

    final dummyState = PrayerLoaded(
      prayerTimes: dummyPrayerTimes,
      nextPrayer: 'Fajr',
      nextPrayerTime: DateTime.now().add(const Duration(hours: 2)),
    );

    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        if (state is PrayerLoading || state is PrayerInitial) {
          return Skeletonizer(
            enabled: true,
            effect: ShimmerEffect(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade500,
            ),
            child: PrayerTimeCard(
              isDark: isDark,
              prayerTimes: dummyPrayerTimes,
              state: dummyState,
              isLoading: true,
            ),
          );
        }

        if (state is PrayerFailure) {
          return Center(child: Text(state.errMessage));
        }

        if (state is PrayerLoaded) {
          return PrayerTimeCard(
            isDark: isDark,
            prayerTimes: state.prayerTimes,
            state: state,
          );
        }

        return const SizedBox();
      },
    );
  }
}
