import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/utils/notification_server.dart';
import 'package:life_cycle/core/utils/task_alarm_services.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:meta/meta.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode =
      AutovalidateMode.disabled;

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController startDateController =
      TextEditingController();


  // Add Task
  Future<void> addTask(TaskModel task) async {
    emit(AddTaskLoading());

    try {
      final tasksBox = Hive.box<TaskModel>(kTasksBox);

      // Save task in Hive
      final taskKey = await tasksBox.add(task);

      debugPrint('TASK SAVED: ${task.title}');
      debugPrint('TASK KEY: $taskKey');
      debugPrint('TASK TIME: ${task.endTime}');

      // Schedule notification
      try {
        await NotificationService.scheduleTaskNotification(
          id: taskKey,
          title: task.title!,
          scheduledDate: task.endTime!,
        );

        debugPrint('TASK NOTIFICATION SCHEDULED');
      } catch (e, stackTrace) {
        debugPrint('TASK NOTIFICATION ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }

      // Schedule alarm
      try {
        await TaskAlarmService.scheduleTaskAlarm(
          id: taskKey,
          title: task.title!,
          scheduledDate: task.endTime!,
        );

        debugPrint('TASK ALARM REQUEST COMPLETED');
      } catch (e, stackTrace) {
        debugPrint('TASK ALARM ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }

      emit(AddTaskSuccess());
    } catch (e, stackTrace) {
      debugPrint('ADD TASK ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      emit(AddTaskFailure(errMessage: e.toString()));
    }
  }

  // Change Auto Validate Mode
  void changeAutoValidateMode() {
    autovalidateMode = AutovalidateMode.always;
    emit(ChangeAutoValidate());
  }

  // Pick Date And Time
 Future<void> pickedDateTime(
  TextEditingController controller,
  BuildContext context,
) async {
  DateTime selectedDateTime = DateTime.now().add(
    const Duration(minutes: 1),
  );

  final weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String formatDateTime(DateTime date) {
    final dayName = weekDays[date.weekday - 1];
    final monthName = months[date.month - 1];

    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$dayName, ${date.day} $monthName ${date.year} • $hour:$minute';
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.textPrimary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: 420.h,
            child: Column(
              children: [
                verticalSpace(20.h),

                // Title
                Text(
                  'Set Reminder',
                  style: AppTextStyles.interWhite(
                    22,
                    FontWeight.bold,
                  ),
                ),

                verticalSpace(12.h),

                // Selected Date And Time
                Text(
                  formatDateTime(selectedDateTime),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.interWhite(
                    17,
                    FontWeight.w500,
                  ).copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),

                verticalSpace(12.h),

                // Date And Time Picker
                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: AppColors.kPrimaryColor,
                      brightness: Brightness.dark,
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      minimumDate: DateTime.now(),
                      initialDateTime: selectedDateTime,
                      use24hFormat: true,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          selectedDateTime = dateTime;
                        });
                      },
                    ),
                  ),
                ),

                // Done Button
                Padding(
                  padding: EdgeInsets.all(16.h),
                  child: CustomButton(
                    onTap: () {
                      if (!selectedDateTime.isAfter(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select a future date and time',
                            ),
                          ),
                        );
                        return;
                      }

                      controller.text =
                          '${selectedDateTime.day.toString().padLeft(2, '0')}/'
                          '${selectedDateTime.month.toString().padLeft(2, '0')}/'
                          '${selectedDateTime.year}  '
                          '${selectedDateTime.hour.toString().padLeft(2, '0')}:'
                          '${selectedDateTime.minute.toString().padLeft(2, '0')}';

                      emit(ChangeDate());Navigator.pop(sheetContext);
                    },
                    onCenter: Center(
                      child: Text(
                        'Done',
                        style: AppTextStyles.interWhite(
                          20,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  // Get Selected Date And Time
  DateTime getSelectedDateTime() {
    final parts = startDateController.text.split('  ');

    final dateParts = parts[0].split('/');
    final timeParts = parts[1].split(':');

    return DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  @override
  Future<void> close() {
    titleController.dispose();
    startDateController.dispose();

    return super.close();
  }

}