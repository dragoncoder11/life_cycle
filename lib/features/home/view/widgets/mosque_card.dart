import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class MosqueCard extends StatelessWidget {
  const MosqueCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              'assets/images/light_prayer.png',
              height: 100.h,
              width: 125.w,
              fit: BoxFit.fill,
            ),
          ),
          horizontalSpace(16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.mosque,
                    color: AppColors.kPrimaryDark,
                    size: 15.sp,
                  ),
                  horizontalSpace(8),
                  Text(
                    'Next Prayer',
                    style: AppTextStyles.interDarkGreen(13, FontWeight.w600),
                  ),
                ],
              ),
              verticalSpace(2),
              Text('Asr', style: AppTextStyles.interBlack(24, FontWeight.bold)),
              verticalSpace(2),
              Row(
                children: [
                  Icon(
                    Icons.history_toggle_off,
                    color: AppColors.kPrimaryDark,
                    size: 15.sp,
                  ),
                  horizontalSpace(8),
                  Text(
                    '03:15 PM',
                    style: AppTextStyles.interBlack(14, FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
