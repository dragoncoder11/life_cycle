import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key, this.icon, this.onPressed,
  });
final IconData ? icon;
final VoidCallback ? onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.kPrimaryColor,
      child: Center(
        child: IconButton(onPressed: onPressed, icon: Icon(icon,color: AppColors.background), iconSize: 24)
      ),
    );
  }
}
