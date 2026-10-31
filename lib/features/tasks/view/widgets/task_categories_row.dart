
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/widgets/custom_category_card.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';

class TaskCategoriesRow extends StatelessWidget {
  const TaskCategoriesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        final cubit = context.read<TasksCubit>();

        return SizedBox(
          height: 50.h,
          width: double.infinity,
          child: Row(
            children: [
              // Today
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

              // Upcoming
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    cubit.changeIndex(1);
                  },
                  child: CustomCategoryCard(
                    title: 'Upcoming',
                    color: cubit.selectedIndex == 1
                        ? AppColors.kPrimaryColor
                        : AppColors.switchTrackOff,
                  ),
                ),
              ),

              horizontalSpace(8.w),

              // Completed
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
      },
    );
  }
}
