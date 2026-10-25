import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/notifications/view/widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(12.h),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
                    Navigator.pop(context);
                  },),
                  Text(
                    'Notifications',
                    style: AppTextStyles.interBlack(24, FontWeight.bold),
                  ),
                ],
              ),
              verticalSpace(10),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return NotificationItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
