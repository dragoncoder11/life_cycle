import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  final List<dynamic> onboardingData = const [
    {
      'image': 'assets/images/onBoarding_1.png',
      'title': 'Capture Your Thoughts',
      'description':
          'Save your notes , ideas and important things whenever you want.',
    },
    {
      'image': 'assets/images/onBoarding_2.png',
      'title': 'Organize Your Notes',
      'description':
          'Keep your notes organized and easily accessible with our intuitive categorization system.',
    },
    {
      'image': 'assets/images/onBoarding_3.png',
      'title': 'Sync Across Devices',
      'description':
          'Access your notes from anywhere, on any device, with seamless synchronization.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 24.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 8.h,
                  bottom: 8.h,
                ),
                child: CustomButton(title: 'Get Started', onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.buttonNavBarScreen);
                }),
              ),
            ),
            Positioned(
              bottom: 100.h,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: PageController(),
                  count: 3,
                  effect: JumpingDotEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    activeDotColor: AppColors.kPrimaryColor,
                    dotColor: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 24.h,
              right: 24,
              child: Text(
                'Skip',
                style: AppTextStyles.interGrey(16, FontWeight.w600),
              ),
            ),
            PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 8.h,
                    bottom: 8.h,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 120.h,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              onboardingData[index]['image'],
                              fit: BoxFit.fill,
                              height: 200.h,
                              width: double.infinity,
                            ),
                            verticalSpace(10),
                            Text(
                              onboardingData[index]['title'],
                              style: AppTextStyles.interBlack(
                                24,
                                FontWeight.bold,
                              ),
                            ),
                            verticalSpace(10),
                            Text(
                              textAlign: TextAlign.center,
                              onboardingData[index]['description'],
                              style: AppTextStyles.interGrey(
                                14,
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
