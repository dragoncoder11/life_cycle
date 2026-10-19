import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/home/view/screens/home_screen.dart';

class ButtonNavBarScreen extends StatelessWidget {
  const ButtonNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
        child: HomeScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Finance'),
        ],
      ),
    );
  }
}
