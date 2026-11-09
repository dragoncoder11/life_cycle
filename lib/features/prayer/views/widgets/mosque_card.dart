import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';

class MosqueCard extends StatelessWidget {
  const MosqueCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50.r),
              bottomLeft: Radius.circular(16.r),
            ),
            child: Image.asset(
              isDark
                  ? 'assets/images/night_prayer.png'
                  : 'assets/images/light_prayer.png',
              height: 100.h,
              width: 125.w,
              fit: BoxFit.fill,
            ),
          ),
          horizontalSpace(16),
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

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.mosque,
                          color: isDark
                              ? AppColors.whiteColor
                              : AppColors.kPrimaryDark,
                          size: 15.sp,
                        ),
                        horizontalSpace(8),
                        Text(
                          'Next Prayer',
                          style:
                              AppTextStyles.interPrimaryDark(
                                13,
                                FontWeight.w600,
                              ).copyWith(
                                color: isDark
                                    ? AppColors.whiteColor
                                    : AppColors.kPrimaryDark,
                              ),
                        ),
                      ],
                    ),
                    verticalSpace(2),
                    Text(
                      state.nextPrayerName,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24.sp),
                    ),
                    verticalSpace(2),
                    Row(
                      children: [
                        Icon(
                          Icons.history_toggle_off,
                          color: isDark
                              ? AppColors.whiteColor
                              : AppColors.kPrimaryDark,
                          size: 15.sp,
                        ),
                        horizontalSpace(8),
                        Text(
                          '${state.nextPrayerTime} PM',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
