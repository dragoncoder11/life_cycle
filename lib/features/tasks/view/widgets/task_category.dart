
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class TaskCategory extends StatelessWidget {
  const TaskCategory({
    super.key, required this.title,
  });
final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Text(
          'Today',
          style: AppTextStyles.interWhite(16, FontWeight.w600),
        ),
      ),
    );
  }
}
