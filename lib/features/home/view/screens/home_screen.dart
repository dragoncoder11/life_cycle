import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/home/view/widgets/home_card_grid_view.dart';
import 'package:life_cycle/features/home/view/widgets/mosque_card.dart';
import 'package:life_cycle/features/home/view/widgets/prayer_times_today_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              verticalSpace(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/home_logo.png',
                        height: 40.h,
                        width: 40.w,
                        fit: BoxFit.cover,
                      ),
                      horizontalSpace(10),
                      Text(
                        'Life Cycle',
                        style: AppTextStyles.interDarkGreen(
                          24,
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.notificationsScreen,
                          );
                        },
                        child: CustomCircleAvatar(
                          color: AppColors.greyColor.withOpacity(.2),
                          icon: Icons.notifications_none_rounded,
                          iconSize: 30.r,
                          iconColor: AppColors.kPrimaryColor,
                        ),
                      ),
                      horizontalSpace(8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.settingScreen);
                        },
                        child: CustomCircleAvatar(
                          color: AppColors.greyColor.withOpacity(.2),
                          icon: Icons.settings_outlined,
                          iconSize: 30.r,
                          iconColor: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpace(15.h),
              Row(
                children: [
                  Text(
                    'Good Morning..',
                    style: AppTextStyles.interBlack(
                      24,
                      FontWeight.bold,
                    ),
                  ),
                  horizontalSpace(5),
                  Icon(
                    Icons.sunny,
                    color: AppColors.financeYellow,
                    size: 32,
                  ),
                ],
              ),
              verticalSpace(4),
              Text(
                'Small steps make big progress',
                style: AppTextStyles.interGrey(
                  12,
                  FontWeight.w600,
                ),
              ),
              verticalSpace(8),
              MosqueCard(),
              verticalSpace(8),
              PrayerTimesTodayCard(),
              verticalSpace(8),
            ]),
          ),
          HomeCardGridView(),
          
        ],
      ),
    );
  }
}