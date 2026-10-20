import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_card.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_category.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tasks',
                style: AppTextStyles.interBlack(24, FontWeight.bold),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    child: Card(
                      color: AppColors.background,
                      shadowColor: AppColors.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.notifications,
                                size: 32.r,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.notifications,
                                color: AppColors.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(5),
                  CustomCircleAvatar(icon: Icons.add, onPressed: () {}),
                ],
              ),
            ],
          ),
          verticalSpace(12.h),

          SizedBox(
            height: 50.h,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(child: TaskCategory(title: 'Today',)),
                horizontalSpace(8.w),
                Expanded(child: TaskCategory(title: 'UpComing',)),
                horizontalSpace(8.w),
                Expanded(child: TaskCategory(title: 'Completed',)),
              ],
            ),
          ),
          verticalSpace(12.h),
          TaskCard(),
        ],
      ),
    );
  }
}
