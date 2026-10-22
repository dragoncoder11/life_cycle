
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class CustomCategoryCard extends StatelessWidget {
  const CustomCategoryCard({
    super.key, required this.title, this.color=AppColors.switchTrackOff,
  });
final String title;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.interWhite(13, FontWeight.bold),
        ),
      ),
    );
  }
}
