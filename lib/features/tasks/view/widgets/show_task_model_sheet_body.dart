import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/notes/logic/add_note_cubit/add_note_cubit.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:life_cycle/features/tasks/logic/add_task/add_task_cubit.dart';
import 'package:life_cycle/features/tasks/logic/get_tasks/tasks_cubit.dart';

class ShowTaskModelSheetBody extends StatelessWidget {
  const ShowTaskModelSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddTaskCubit>(context);
    return Container(
      decoration: BoxDecoration(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Task',
                  style: AppTextStyles.interWhite(16, FontWeight.w500),
                ),
                verticalSpace(4.h),

                CustomTextFormField(
                  textStyle: AppTextStyles.interWhite(16, FontWeight.w600),
                  hintText: 'e.g finish the project',
                  controller: cubit.titleController,
                  validate: (value) {
                    if (value == null || value.trim() == '') {
                      return 'field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                verticalSpace(6.h),

                Text(
                  'From',
                  style: AppTextStyles.interWhite(16, FontWeight.w500),
                ),
                verticalSpace(4),
                CustomTextFormField(
                  onTap: () {
                    cubit.pickedTheDate(cubit.startDateController, context);
                  },
                  textStyle: AppTextStyles.interWhite(16, FontWeight.w600),
                  hintText: 'Select date',
                  maxLines: 1,
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: AppColors.background,
                  ),
                  textInputType: TextInputType.datetime,
                  controller: cubit.startDateController,
                  validate: (value) {
                    if (value == null || value.trim() == '') {
                      return 'field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                verticalSpace(6.h),

                Text(
                  'Time',
                  style: AppTextStyles.interWhite(16, FontWeight.w500),
                ),
                verticalSpace(4),
                CustomTextFormField(
                  onTap: () {
                    cubit.pickedTheDate(cubit.endDateController, context);
                  },

                  textStyle: AppTextStyles.interWhite(16, FontWeight.w600),
                  hintText: 'Select time',
                  maxLines: 1,
                  prefixIcon: Icon(Icons.schedule, color: AppColors.background),
                  textInputType: TextInputType.datetime,
                  controller: cubit.endDateController,
                  validate: (value) {
                    if (value == null || value.trim() == '') {
                      return 'field is required';
                    } else {
                      return null;
                    }
                  },
                ),
                verticalSpace(40.h),
                BlocConsumer<AddTaskCubit, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                    }
                    if (state is AddTaskSuccess) {
                      context.read<TasksCubit>().fetchTasks();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      onTap: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          final startTime = DateTime(
                            int.parse(
                              cubit.startDateController.text.split('/')[2],
                            ),
                            int.parse(
                              cubit.startDateController.text.split('/')[1],
                            ),
                            int.parse(
                              cubit.startDateController.text.split('/')[0],
                            ),
                          );

                          final endTime = DateTime(
                            int.parse(
                              cubit.endDateController.text.split('/')[2],
                            ),
                            int.parse(
                              cubit.endDateController.text.split('/')[1],
                            ),
                            int.parse(
                              cubit.endDateController.text.split('/')[0],
                            ),
                          );

                          final taskModel = TaskModel(
                            title: cubit.titleController.text,
                            startTime: startTime,
                            endTime: endTime,
                            isCompleted: false,
                            date: DateTime.now().toString(),
                          );

                          await cubit.addTask(taskModel);
                        } else {
                          cubit.changeAutoValidateMode();
                        }
                      },
                      onCenter: Center(
                        child: state is AddTaskLoading
                            ? CircularProgressIndicator()
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
