
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/home/view/widgets/home_card_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(30.h),
        Image.asset(
          'assets/images/home.png',
          height: 180.h,
          width: double.infinity,
        ),
        verticalSpace(12.h),
        Row(
          children: [
            Text(
              'Good Morning..',
              style: AppTextStyles.interBlack(24, FontWeight.bold),
            ),
            horizontalSpace(5),
            Icon(Icons.sunny, color: AppColors.financeYellow, size: 32),
          ],
        ),
        verticalSpace(4),
        Text(
          'Small steps make big progress',
          style: AppTextStyles.interGrey(12, FontWeight.w600),
        ),
        verticalSpace(8),
    
        HomeCardGridView(),
      ],
    );
  }
}
