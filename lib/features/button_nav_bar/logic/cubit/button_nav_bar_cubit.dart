import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/screens/finance_screen.dart';
import 'package:life_cycle/features/home/view/screens/home_screen.dart';
import 'package:life_cycle/features/notes/logic/add_note_cubit/add_note_cubit.dart';
import 'package:life_cycle/features/notes/view/screens/note_screen.dart';
import 'package:life_cycle/features/tasks/logic/cubit/tasks_cubit.dart';
import 'package:life_cycle/features/tasks/view/screens/task_screen.dart';
import 'package:meta/meta.dart';

part 'button_nav_bar_state.dart';

class ButtonNavBarCubit extends Cubit<ButtonNavBarState> {
  ButtonNavBarCubit() : super(ButtonNavBarInitial());
  int selectedIndex = 0;

  void changeIndex(int index) {
    //  if (selectedIndex == index) return;

    selectedIndex = index;
    emit(ChangeIndex());
  }

  List<Widget> getScreens() {
    return [
      const HomeScreen(),
      BlocProvider(
        create: (context) => AddNoteCubit(),
        child: const NoteScreen(),
      ),
      BlocProvider(create: (_) => TasksCubit(), child: const TaskScreen()),
      BlocProvider(
        create: (context) => TransactionCategoriesCubit(),
        child: const FinanceScreen(),
      ),
    ];
  }
}
