import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/prayer/logic/prayer_cubit/prayer_cubit.dart';

class MosqueCard extends StatelessWidget {
  const MosqueCard({super.key});

  String formatPrayerTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

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
              width: 115.w,
              fit: BoxFit.cover,
            ),
          ),

          horizontalSpace(10),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: BlocBuilder<PrayerCubit, PrayerState>(
                builder: (context, state) {
                  if (state is PrayerLoading ||
                      state is PrayerInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ),
                    );
                  }

                  if (state is PrayerFailure) {
                    return Center(
                      child: Text(
                        state.errMessage,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }

                  if (state is PrayerLoaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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

                            horizontalSpace(6),

                            Flexible(
                              child: Text(
                                'Next Prayer',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.interPrimaryDark(
                                  13,
                                  FontWeight.w600,
                                ).copyWith(
                                  color: isDark
                                      ? AppColors.whiteColor
                                      : AppColors.kPrimaryDark,
                                ),
                              ),
                            ),
                          ],
                        ),

                        verticalSpace(3),Text(
                          state.nextPrayer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontSize: 24.sp,
                              ),
                        ),

                        verticalSpace(3),

                        Row(
                          children: [
                            Icon(
                              Icons.history_toggle_off,
                              color: isDark
                                  ? AppColors.whiteColor
                                  : AppColors.kPrimaryDark,
                              size: 15.sp,
                            ),

                            horizontalSpace(6),

                            Flexible(
                              child: Text(
                                formatPrayerTime(state.nextPrayerTime),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}