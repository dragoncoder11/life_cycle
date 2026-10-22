import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    emit(IndexChanged());
  }
}
