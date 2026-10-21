import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key, this.icon, this.onPressed, this.iconSize, this.color, this.radius, this.iconColor,
  });
final IconData ? icon;
final VoidCallback ? onPressed;
final double? iconSize;
final Color? color;
final Color? iconColor;
final double?radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius?? 20.r,
      backgroundColor:color?? AppColors.kPrimaryColor,
      child: Center(
        child: IconButton(onPressed: onPressed, icon: Icon(icon,color:iconColor?? AppColors.background), iconSize: iconSize?? 24,padding: EdgeInsets.zero,)
      ),
    );
  }
}
