import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:meta/meta.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
 final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController titleController = TextEditingController();
    TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  addTask(TaskModel task) async {
    emit(AddTaskLoading());
    try {
      var tasksBox = Hive.box<TaskModel>(kTasksBox);
      await tasksBox.add(task);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskFailure(errMessage: e.toString()));
    }
  }

  changeAutoValidateMode() {
    autovalidateMode = AutovalidateMode.always;
    emit(ChangeAutoValidate());
  }
Future<void> pickedTheDate(
  TextEditingController controller,
  BuildContext context,
) async {
  final DateTime? selectDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );

  if (selectDate == null) return;

  controller.text =
      '${selectDate.day.toString().padLeft(2, '0')}/'
      '${selectDate.month.toString().padLeft(2, '0')}/'
      '${selectDate.year}';

  emit(ChangeDate());
}

  @override
Future<void> close() {
  titleController.dispose();
  startDateController.dispose();
  endDateController.dispose();
  return super.close();
}
}
