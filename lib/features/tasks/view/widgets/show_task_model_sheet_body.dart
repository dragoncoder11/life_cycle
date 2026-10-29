
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:life_cycle/features/tasks/logic/add_task/add_task_cubit.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';

class ShowTaskModelSheetBody extends StatelessWidget {
  const ShowTaskModelSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AddTaskCubit>(context);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.textPrimary,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 32.h,
          bottom: 16.w,
          left: 16.w,
          right: 16.w,
        ),
        child: Form(
          key: cubit.formKey,
          autovalidateMode: cubit.autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: AppTextStyles.interWhite(
                    16,
                    FontWeight.w500,
                  ),
                ),

                verticalSpace(4.h),

                CustomTextFormField(
                  textStyle: AppTextStyles.interWhite(
                    16,
                    FontWeight.w600,
                  ),
                  hintText: 'e.g finish the project',
                  controller: cubit.titleController,
                  validate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'field is required';
                    }

                    return null;
                  },
                ),

                verticalSpace(6.h),

                Text(
                  'From',
                  style: AppTextStyles.interWhite(
                    16,
                    FontWeight.w500,
                  ),
                ),

                verticalSpace(4),

                CustomTextFormField(
                  onTap: () {
                    cubit.pickedTheDate(
                      cubit.startDateController,
                      context,
                    );
                  },
                  textStyle: AppTextStyles.interWhite(
                    16,
                    FontWeight.w600,
                  ),
                  hintText: 'Select date',
                  maxLines: 1,
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: AppColors.background,
                  ),
                  controller: cubit.startDateController,
                  readOnly: true,
                  validate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'field is required';
                    }

                    return null;
                  },
                ),

                verticalSpace(6.h),

                Text(
                  'Time',
                  style: AppTextStyles.interWhite(
                    16,
                    FontWeight.w500,
                  ),
                ),

                verticalSpace(4),

                CustomTextFormField(
                  onTap: () {
                    cubit.pickedTheTime(
                      cubit.endDateController,
                      context,
                    );
                  },
                  textStyle: AppTextStyles.interWhite(
                    16,
                    FontWeight.w600,
                  ),
                  hintText: 'Select time',
                  maxLines: 1,
                  prefixIcon: Icon(
                    Icons.schedule,
                    color: AppColors.background,
                  ),
                  controller: cubit.endDateController,
                  readOnly: true,
                  validate: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'field is required';
                    }

                    return null;
                  },
                ),

                verticalSpace(40.h),

                BlocConsumer<AddTaskCubit, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errMessage),
                        ),
                      );
                    }

                    if (state is AddTaskSuccess) {
                      context.read<TasksCubit>().fetchTasks();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      onTap: () async {
                        if (state is AddTaskLoading) return;

                        if (!cubit.formKey.currentState!.validate()) {
                          cubit.changeAutoValidateMode();
                          return;
                        }

                        final DateTime endTime;

                        try {
                          endTime = cubit.getSelectedDateTime();
                        } catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select a valid date and time',
                              ),
                            ),
                          );
                          return;
                        }
                        if (!endTime.isAfter(DateTime.now())) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select a time in the future',
                              ),
                            ),
                          );
                          return;
                        }

                        final taskModel = TaskModel(
                          title: cubit.titleController.text.trim(),
                          endTime: endTime,
                          isCompleted: false,
                          date: endTime.toString(),
                        );

                        await cubit.addTask(taskModel);
                      },
                      onCenter: Center(
                        child: state is AddTaskLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'Add Task',
                                style: AppTextStyles.interWhite(
                                  24,
                                  FontWeight.w600,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
