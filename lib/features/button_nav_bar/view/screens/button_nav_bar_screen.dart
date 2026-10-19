import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/button_nav_bar/logic/cubit/button_nav_bar_cubit.dart';

class ButtonNavBarScreen extends StatelessWidget {
  const ButtonNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonNavBarCubit, ButtonNavBarState>(
      builder: (context, state) {
        var cubit = context.read<ButtonNavBarCubit>();
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
            child: cubit.getScreens()[cubit.selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.selectedIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.kPrimaryColor,
            selectedIconTheme: const IconThemeData(
              size: 28,
              color: AppColors.kPrimaryColor,
            ),
            selectedFontSize: 13,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedItemColor: AppColors.textSecondary,
            unselectedIconTheme: const IconThemeData(
              size: 28,
              color: AppColors.textSecondary,
            ),
            unselectedFontSize: 13,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),

            showSelectedLabels: true,
            showUnselectedLabels: true,

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.note_add),
                label: 'Notes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wallet),
                label: 'Finance',
              ),
            ],
          ),
        );
      },
    );
  }
}
