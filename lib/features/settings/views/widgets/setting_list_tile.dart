import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.subTitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
        vertical: 1.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        leading: Icon(
          icon,
          color: AppColors.kPrimaryDark,
          size: 26.r,
        ),
        title: Text(
          title,
          style: AppTextStyles.interBlack(
            18,
            FontWeight.w600,
          ),
        ),
        subtitle: subTitle != null && subTitle!.isNotEmpty
            ? Text(
                subTitle!,
                style: AppTextStyles.interGrey(
                  14,
                  FontWeight.w500,
                ),
              )
            : null,
        trailing: trailing ??
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18.r,
              color: AppColors.greyColor,
            ),
      ),
    );
  }
}
