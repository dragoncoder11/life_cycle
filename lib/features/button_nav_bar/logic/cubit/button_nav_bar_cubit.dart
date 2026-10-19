import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:life_cycle/features/finance/view/screens/finance_screen.dart';
import 'package:life_cycle/features/home/view/screens/home_screen.dart';
import 'package:life_cycle/features/notes/view/screens/note_screen.dart';
import 'package:life_cycle/features/tasks/view/screens/task_screen.dart';
import 'package:meta/meta.dart';

part 'button_nav_bar_state.dart';

class ButtonNavBarCubit extends Cubit<ButtonNavBarState> {
  ButtonNavBarCubit() : super(ButtonNavBarInitial());
int selectedIndex = 0;

  void changeIndex(int index) {
    if (selectedIndex == index) return;

    selectedIndex = index;
    emit(ChangeIndex());
  }
  List<Widget> getScreens() {
    return [
      const HomeScreen(),
      const NoteScreen(),
      const TaskScreen(),
      const FinanceScreen(),
    ];
  }
}
