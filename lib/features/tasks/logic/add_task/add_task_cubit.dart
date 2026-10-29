import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/core/utils/notification_server.dart';
import 'package:life_cycle/core/utils/task_alarm_services.dart';
import 'package:life_cycle/core/widgets/custom_time_picker.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:meta/meta.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

Future<void> addTask(TaskModel task) async {
  emit(AddTaskLoading());

  try {
    final tasksBox = Hive.box<TaskModel>(kTasksBox);

    // 1. Save the task in Hive.
    final taskKey = await tasksBox.add(task);

    debugPrint('TASK SAVED: ${task.title}');
    debugPrint('TASK KEY: $taskKey');
    debugPrint('TASK TIME: ${task.endTime}');

    // 2. Schedule the regular notification.
    try {
      await NotificationService.scheduleTaskNotification(
        id: taskKey,
        title: task.title,
        scheduledDate: task.endTime,
      );

      debugPrint('TASK NOTIFICATION SCHEDULED');
    } catch (e, stackTrace) {
      debugPrint('TASK NOTIFICATION ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    // 3. Schedule the ringing alarm.
    try {
      await TaskAlarmService.scheduleTaskAlarm(
        id: taskKey,
        title: task.title,
        scheduledDate: task.endTime,
      );

      debugPrint('TASK ALARM REQUEST COMPLETED');
    } catch (e, stackTrace) {
      debugPrint('TASK ALARM ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);
    }

    // The task is saved even if scheduling fails.
    emit(AddTaskSuccess());
  } catch (e, stackTrace) {
    debugPrint('ADD TASK ERROR: $e');
    debugPrintStack(stackTrace: stackTrace);

    emit(AddTaskFailure(errMessage: e.toString()));
  }
}

  void changeAutoValidateMode() {
    autovalidateMode = AutovalidateMode.always;
    emit(ChangeAutoValidate());
  }

  Future<void> pickedTheDate(
    TextEditingController controller,
    BuildContext context,
  ) async {
    final now = DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2030),
    );

    if (selectedDate == null) return;

    controller.text =
        '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';

    // لو غيرت التاريخ، امسح الوقت السابق
    // عشان ممكن يكون عدى بالفعل.
    endDateController.clear();

    emit(ChangeDate());
  }

  Future<void> pickedTheTime(
    TextEditingController controller,
    BuildContext context,
  ) async {
    if (startDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date first')),
      );
      return;
    }

    final dateParts = startDateController.text.split('/');

    final selectedDate = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
    );

    final today = DateTime.now();

    if (selectedDate.isBefore(DateTime(today.year, today.month, today.day))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a future date')),
      );
      return;
    }

    final TimeOfDay? selectedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) {
        return CustomTimePicker(selectedDate: selectedDate);
      },
    );

    if (selectedTime == null) return;

    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (!selectedDateTime.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time in the future')),
      );
      return;
    }

    controller.text =
        '${selectedTime.hour.toString().padLeft(2, '0')}:'
        '${selectedTime.minute.toString().padLeft(2, '0')}';

    emit(ChangeDate());
  }

  DateTime getSelectedDateTime() {
    final dateParts = startDateController.text.split('/');
    final timeParts = endDateController.text.split(':');

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
    endDateController.dispose();

    return super.close();
  }
}
