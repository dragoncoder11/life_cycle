import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TasksCubit>(context);

    final args =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, dynamic>;

    final taskModel = args['task'] as TaskModel;

    // Initialize Controllers Once
    cubit.initEditTask(taskModel);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
            top: 16.h,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      verticalSpace(10.h),

                      Text(
                        'Edit Task',
                        style: AppTextStyles.interBlack(
                          24,
                          FontWeight.bold,
                        ),
                      ),

                      verticalSpace(12.h),

                      Text(
                        'Edit Task Title',
                        style: AppTextStyles.interBlack(
                          16,
                          FontWeight.w500,
                        ),
                      ),

                      verticalSpace(4.h),

                      CustomTextFormField(
                        controller: cubit.taskTitle,
                        maxLines: 1,
                        filled: true,
                      ),

                      verticalSpace(12.h),

                      Text(
                        'Edit Date & Time',
                        style: AppTextStyles.interBlack(
                          16,
                          FontWeight.w500,
                        ),
                      ),

                      verticalSpace(4.h),

                      TextFormField(
                        controller: cubit.taskEndDate,
                        readOnly: true,
                        onTap: () {
                          cubit.pickEditDateTime(context);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.date_range,
                          ),
                          hintText: 'Select Date & Time',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              CustomButton(
                onTap: () async {
                  await cubit.editTask(taskModel);if (context.mounted) {
                    cubit.fetchTasks();
                    Navigator.pop(context);
                  }
                },
                title: 'Edit Task',
              ),
            ],
          ),
        ),
      ),
    );
  }
}