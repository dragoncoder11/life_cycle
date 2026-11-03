
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/utils/notification_server.dart';
import 'package:life_cycle/core/utils/task_alarm_services.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial()) {
    startTasksTimer();
  }

  int selectedIndex = 0;

  List<TaskModel> tasks = [];

  Timer? tasksTimer;

  // Controllers
  TextEditingController? taskTitle;
  TextEditingController? taskEndDate;

  // Selected Date
  DateTime? selectedEndTime;

  // Task currently being edited
  TaskModel? editingTask;

  // Change Category
  void changeIndex(int index) {
    if (selectedIndex == index) return;

    selectedIndex = index;

    emit(IndexChanged());
  }

  // Fetch Tasks From Hive
  void fetchTasks() {
    final tasksBox = Hive.box<TaskModel>(kTasksBox);

    tasks = tasksBox.values.toList();

    emit(TasksSuccess());
  }

  // Task Selection
  Set<TaskModel> selectedTasks = {};

  bool get isSelectionMode => selectedTasks.isNotEmpty;

  void toggleTaskSelection(TaskModel task) {
    if (selectedTasks.contains(task)) {
      selectedTasks.remove(task);
    } else {
      selectedTasks.add(task);
    }

    emit(TasksSuccess());
  }

  // Delete Selected Tasks
  Future<void> deleteSelectedTasks() async {
    final tasksToDelete = selectedTasks.toList();

    for (final task in tasksToDelete) {
      final taskId = task.key as int;

      await NotificationService.cancelTaskNotification(taskId);

      await TaskAlarmService.cancelTaskAlarm(taskId);

      await task.delete();

      debugPrint('TASK DELETED: $taskId');
    }

    selectedTasks.clear();

    fetchTasks();
  }

  void clearSelection() {
    selectedTasks.clear();
    emit(TasksSuccess());
  }

  bool isTaskSelected(TaskModel task) {
    return selectedTasks.contains(task);
  }

  // Tasks Timer
  void startTasksTimer() {
    tasksTimer?.cancel();

    tasksTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        emit(TasksChangesBetweenCategories());
      },
    );
  }

  // Initialize Edit Task
  void initEditTask(TaskModel task) {
    if (identical(editingTask, task)) return;

    taskTitle?.dispose();
    taskEndDate?.dispose();

    editingTask = task;

    taskTitle = TextEditingController(
      text: task.title ?? '',
    );

    selectedEndTime = task.endTime;

    taskEndDate = TextEditingController(
      text: task.endTime == null
          ? ''
          : DateFormat('dd/MM/yyyy  HH:mm')
              .format(task.endTime!),
    );
  }

  // Pick New Date And Time
  Future<void> pickEditDateTime(BuildContext context) async {
    final now = DateTime.now();

    final minimumDate = now.add(
      const Duration(minutes: 1),
    );

    DateTime selectedDateTime =
        selectedEndTime != null &&
                selectedEndTime!.isAfter(now)
            ? selectedEndTime!
            : minimumDate;

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
      backgroundColor: AppColors.darkGreenColor,
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
                    'Edit Reminder',
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
                        minimumDate: minimumDate,
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

                        selectedEndTime = selectedDateTime;

                        taskEndDate?.text =
                            '${selectedDateTime.day.toString().padLeft(2, '0')}/'
                            '${selectedDateTime.month.toString().padLeft(2, '0')}/'
                            '${selectedDateTime.year}  '
                            '${selectedDateTime.hour.toString().padLeft(2, '0')}:'
                            '${selectedDateTime.minute.toString().padLeft(2, '0')}';

                        emit(TasksSuccess());

                        Navigator.pop(sheetContext);
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

  // Edit Task
  Future<void> editTask(TaskModel task) async {
    if (taskTitle == null ||
        taskTitle!.text.trim().isEmpty ||
        selectedEndTime == null) {
      return;
    }

    if (!selectedEndTime!.isAfter(DateTime.now())) {
      return;
    }

    final taskId = task.key as int;

    task.title = taskTitle!.text.trim();

    task.endTime = selectedEndTime;

    await task.save();

    // Cancel old notification
    await NotificationService.cancelTaskNotification(taskId);

    // Cancel old alarm
    await TaskAlarmService.cancelTaskAlarm(taskId);

    // Schedule updated notification
    await NotificationService.scheduleTaskNotification(
      id: taskId,
      title: task.title!,
      scheduledDate: task.endTime!,
    );

    // Schedule updated alarm
    await TaskAlarmService.scheduleTaskAlarm(
      id: taskId,
      title: task.title!,
      scheduledDate: task.endTime!,
    );

    fetchTasks();
  }

  @override
  Future<void> close() {
    tasksTimer?.cancel();

    taskTitle?.dispose();
    taskEndDate?.dispose();

    return super.close();
  }
}
