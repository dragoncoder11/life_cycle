import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
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
          : DateFormat('dd/MM/yyyy hh:mm a')
              .format(task.endTime!),
    );
  }

  // Pick New Date And Time
  Future<void> pickEditDateTime(BuildContext context) async {
    final initialDate = selectedEndTime ?? DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null || !context.mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    if (pickedTime == null) return;

    selectedEndTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    taskEndDate?.text = DateFormat('dd/MM/yyyy hh:mm a')
        .format(selectedEndTime!);

    emit(TasksSuccess());
  }

  // Edit Task
  Future<void> editTask(TaskModel task) async {
    if (taskTitle == null ||
        taskTitle!.text.trim().isEmpty ||
        selectedEndTime == null) {
      return;
    }

    task.title = taskTitle!.text.trim();

    task.endTime = selectedEndTime;

    await task.save();

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