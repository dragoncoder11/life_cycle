
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.pushNamed(context, Routes.addBalanceScreen,);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Balance',
                  style: AppTextStyles.interBlack(14, FontWeight.w500),
                ),
                verticalSpace(10),
                Text(
                  '4000 EGP',
                  style: AppTextStyles.interBlack(20, FontWeight.bold),
                ),
              ],
            ),
            CustomCircleAvatar(
              radius: 28.r,
              icon: Icons.wallet,
              iconSize: 32.r,
              color: AppColors.income,
            ),
          ],
        ),
      ),
    );
  }
}
