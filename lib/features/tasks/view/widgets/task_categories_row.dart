
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/widgets/custom_category_card.dart';
import 'package:life_cycle/features/tasks/logic/cubit/tasks_cubit.dart';

class TaskCategoriesRow extends StatelessWidget {
  const TaskCategoriesRow({
    super.key,
    required this.cubit,
  });

  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(0);
              },
              child: CustomCategoryCard(
                title: 'Today',
                color: cubit.selectedIndex == 0
                    ? AppColors.kPrimaryColor
                    : AppColors.switchTrackOff,
              ),
            ),
          ),
          horizontalSpace(8.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(1);
              },
              child: CustomCategoryCard(
                title: 'UpComing',
                color: cubit.selectedIndex == 1
                    ? AppColors.kPrimaryColor
                    : AppColors.switchTrackOff,
              ),
            ),
          ),
          horizontalSpace(8.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                cubit.changeIndex(2);
              },
              child: CustomCategoryCard(
                title: 'Completed',
                color: cubit.selectedIndex == 2
                    ? AppColors.kPrimaryColor
                    : AppColors.switchTrackOff,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
