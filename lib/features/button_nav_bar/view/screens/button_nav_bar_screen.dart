import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/status_bar_mode.dart';
import 'package:life_cycle/features/button_nav_bar/logic/cubit/button_nav_bar_cubit.dart';

class ButtonNavBarScreen extends StatelessWidget {
  const ButtonNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonNavBarCubit, ButtonNavBarState>(
      builder: (context, state) {
        final cubit = context.read<ButtonNavBarCubit>();

        return StatusBarMode(
          child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
                    child: cubit.getScreens()[cubit.selectedIndex],
                  ),
                ),
          
                Positioned(
                  left: 20.w,
                  right: 20.w,
                  bottom: MediaQuery.of(context).padding.bottom + 4.h,
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(35.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _navItem(
                          icon: Icons.home_outlined,
                          selectedIcon: Icons.home,
                          label: 'Home',
                          index: 0,
                          selectedIndex: cubit.selectedIndex,
                          onTap: () => cubit.changeIndex(0),
                        ),
                        _navItem(
                          icon: Icons.note_alt_outlined,
                          selectedIcon: Icons.note_alt,
                          label: 'Notes',
                          index: 1,
                          selectedIndex: cubit.selectedIndex,
                          onTap: () => cubit.changeIndex(1),
                        ),
                        _navItem(
                          icon: Icons.check_box_outlined,
                          selectedIcon: Icons.check_box,
                          label: 'Tasks',
                          index: 2,
                          selectedIndex: cubit.selectedIndex,
                          onTap: () => cubit.changeIndex(2),
                        ),
                        _navItem(
                          icon: Icons.account_balance_wallet_outlined,
                          selectedIcon: Icons.account_balance_wallet,
                          label: 'Finance',
                          index: 3,
                          selectedIndex: cubit.selectedIndex,
                          onTap: () => cubit.changeIndex(3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final isSelected = index == selectedIndex;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected
                    ? AppColors.kPrimaryColor.withOpacity(0.12)
                    : Colors.transparent,
                // shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: 24.sp,
                color: isSelected
                    ? AppColors.kPrimaryColor
                    : AppColors.greyColor,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? AppColors.kPrimaryColor
                    : AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
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
            unselectedItemColor: AppColors.greyColor,
            unselectedIconTheme: const IconThemeData(
              size: 28,
              color: AppColors.greyColor,
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
*/
