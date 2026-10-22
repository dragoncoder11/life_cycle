import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_category_card.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/tasks/logic/cubit/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/widgets/show_task_model_sheet_body.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_card.dart';

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
                  CustomCircleAvatar(icon: Icons.add,   onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return ShowTaskModelSheetBody();
                    },
                  );
                },),
                ],
              ),
            ],
          ),
          verticalSpace(12.h),

          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              var cubit = context.read<TasksCubit>();
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
            },
          ),
          verticalSpace(12.h),
          TaskCard(),
        ],
      ),
    );
  }
}
