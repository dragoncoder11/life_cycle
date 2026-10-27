import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.title, this.onTap, this.onCenter});
 final String? title;
 final GestureTapCallback? onTap;
 final Widget? onCenter;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style:ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.kPrimaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 50.h)),
      ),
      child: onCenter?? Text(
        title!,
        style: AppTextStyles.interWhite(24, FontWeight.w600),
      ),
    );
  }
}
// GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.kPrimaryColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         height: 50.h,
//         width: double.infinity,
//         child: Center(child: Text(title,style: AppTextStyles.interWhite(24, FontWeight.w600),),),
//       ),