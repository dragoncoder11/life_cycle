import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/routing/routes.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/onBoarding/view/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _pulseController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoRotation;
  late final Animation<double> _logoFade;

  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;

  late final Animation<double> _taglineFade;
  late final Animation<Offset> _organizeSlide;
  late final Animation<Offset> _archiveSlide;

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Logo scale animation
    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    // Logo rotation animation
    _logoRotation = Tween<double>(begin: -0.15, end: 0.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    // Logo fade animation
    _logoFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
    );

    // App title fade animation
    _titleFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.3, 0.65, curve: Curves.easeIn),
    );

    // App title slides upward
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.6), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _introController,
            curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic),
          ),
        );

    // Organize slides in from the left
    _organizeSlide =
        Tween<Offset>(begin: const Offset(-1.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _introController,
            curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    // Archive slides in from the right
    _archiveSlide = Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _introController,
            curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    // Tagline fade animation
    _taglineFade = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.45, 0.85, curve: Curves.easeIn),
    );
  
    // Start animations
   // Start animations
_introController.forward();
_pulseController.repeat(reverse: true);

// Navigate to OnBoarding after 3 seconds
Future.delayed(const Duration(seconds: 3), () {
  if (!mounted) return;

  Navigator.pushReplacementNamed(
    context,
    Routes.buttonNavBarScreen, // Use the constant from Routes class
  );
});

  }

  @override
  void dispose() {
    _introController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            FadeTransition(
              opacity: _logoFade,
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _logoScale,
                  _logoRotation,
                  _pulseController,
                ]),
                builder: (context, child) {
                  final pulse = 1.0 + (_pulseController.value * 0.035);

                  return Transform.rotate(
                    angle: _logoRotation.value,
                    child: Transform.scale(
                      scale: _logoScale.value * pulse,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  height: 170.h,
                  width: 170.w,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(
                      color: AppColors.primaryLight.withValues(alpha: 0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryLight.withValues(alpha: 0.2),
                        blurRadius: 35.r,
                        spreadRadius: 3.r,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: Image.asset(
                      'assets/images/splash_1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 28.h),

            // Animated app name
            FadeTransition(
              opacity: _titleFade,
              child: SlideTransition(
                position: _titleSlide,
                child: Text(
                  'Life Cycle',
                  style: TextStyle(
                    color: AppColors.textOnPrimary,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            SizedBox(height: 14.h),

            // Organize from left and Archive from right
            FadeTransition(
              opacity: _taglineFade,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Organize: slides in from the left
                  SlideTransition(
                    position: _organizeSlide,
                    child: Text(
                      'Organize',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(width: 6.w),

                  Text(
                    '•',
                    style: TextStyle(color: AppColors.accent, fontSize: 16.sp),
                  ),

                  SizedBox(width: 6.w),

                  // Plan: fades in from the center
                  FadeTransition(
                    opacity: _taglineFade,
                    child: Text(
                      'Plan',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(width: 6.w),

                  Text(
                    '•',
                    style: TextStyle(color: AppColors.accent, fontSize: 16.sp),
                  ),

                  SizedBox(width: 6.w),

                  // Achieve: slides in from the right
                  SlideTransition(
                    position: _archiveSlide,
                    child: Text(
                      'Achieve',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 45.h),

            // Animated loading indicator
            FadeTransition(
              opacity: _taglineFade,
              child: SizedBox(
                width: 90.w,
                child: LinearProgressIndicator(
                  minHeight: 3.h,
                  backgroundColor: AppColors.surface.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accent,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
