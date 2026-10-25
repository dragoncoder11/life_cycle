import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/tasks/logic/cubit/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/widgets/show_task_model_sheet_body.dart';
import 'package:life_cycle/features/tasks/view/widgets/task_categories_row.dart';
import 'package:life_cycle/features/tasks/view/widgets/tasks_listview.dart';

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
              CustomCircleAvatar(
                icon: Icons.add,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (context) {
                      return AnimatedPadding(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.viewInsetsOf(context).bottom,
                        ),
                        child: ShowTaskModelSheetBody(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          verticalSpace(12.h),

          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              var cubit = context.read<TasksCubit>();
              return TaskCategoriesRow(cubit: cubit);
            },
          ),
          verticalSpace(12.h),
          Expanded(child: TasksListview()),
        ],
      ),
    );
  }
}
