import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle setInterTextStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
    );
  }

  static TextStyle interWhite(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.whiteColor,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interBlack(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.darkGreenColor,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interGrey(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.greyColor,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interLightGreen(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.kPrimaryColor,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interDarkGreen(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.kPrimaryDark,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interRed(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.expense,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }
}
