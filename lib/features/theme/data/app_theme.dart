import 'package:flutter/material.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.whiteColor,

  colorScheme: const ColorScheme.light(
    primary: AppColors.kPrimaryColor,
    surface: AppColors.whiteColor,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.darkGreenColor,
  ),

  textTheme: TextTheme(
    displayLarge: AppTextStyles.interWhite(24, FontWeight.bold),

    displayMedium: AppTextStyles.interWhite(18, FontWeight.bold),

    displaySmall: AppTextStyles.interWhite(16, FontWeight.w600),

    headlineMedium: AppTextStyles.interWhite(14, FontWeight.w500),

    titleLarge: AppTextStyles.interWhite(12, FontWeight.w600),

    titleMedium: AppTextStyles.interWhite(11, FontWeight.w500),
  ),
);
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: AppColors.scaffoldBackground,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.kPrimaryColor,
    surface: AppColors.notificationCard,
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.bottomSheet,
  ),

  textTheme: TextTheme(
    displayLarge: AppTextStyles.interWhite(24, FontWeight.bold),

    displayMedium: AppTextStyles.interWhite(18, FontWeight.bold),

    displaySmall: AppTextStyles.interWhite(16, FontWeight.w600),

    headlineMedium: AppTextStyles.interWhite(14, FontWeight.w500),

    titleLarge: AppTextStyles.interWhite(12, FontWeight.w600),

    titleMedium: AppTextStyles.interWhite(11, FontWeight.w500),
  ),
);
