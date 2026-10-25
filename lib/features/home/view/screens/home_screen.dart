import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/app_routes.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/home/view/widgets/home_card_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(30.h),
        Image.asset(
          'assets/images/home.png',
          height: 160.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        verticalSpace(12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.notificationsScreen);
              },
              child: CircleAvatar(
                radius: 22.r,
                child: Card(
                  color: AppColors.background,
                  shadowColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.notifications,
                            size: 32.r,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.background,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
