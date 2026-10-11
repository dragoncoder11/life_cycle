import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_1.png',
              height: 150.h,
              width: 150.w,
              fit: BoxFit.fill,
            ),
            verticalSpace(20.h),
            Text(
              'Life Cycle',
              style: TextStyle(
                color: AppColors.textOnPrimary,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
              verticalSpace(5.h),
            Text(
              'Organize - Plan - Achieve',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}