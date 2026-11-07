// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';

// import 'package:life_cycle/core/helper/spacing.dart';
// import 'package:life_cycle/core/theme/app_colors.dart';
// import 'package:life_cycle/core/theme/app_text_styles.dart';
// import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

// class NotificationItem extends StatelessWidget {
//   const NotificationItem({
//     super.key,
//     required this.title,
//     required this.body,
//     required this.date,
//     required this.icon,
//     required this.iconColor,
//   });

//   final String title;
//   final String body;
//   final DateTime date;
//   final IconData icon;
//   final Color iconColor;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 5.h),
//       child: Card(
//         elevation: 3,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.08),
//                 blurRadius: 2,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 CustomCircleAvatar(
//                   color: iconColor,
//                   icon: icon,
//                   iconColor: AppColors.whiteColor,
//                 ),

//                 horizontalSpace(12),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: AppTextStyles.interBlack(
//                           16,
//                           FontWeight.bold,
//                         ),
//                       ),

//                       verticalSpace(4),

//                       Text(
//                         body,
//                         style: AppTextStyles.interGrey(
//                           12,
//                           FontWeight.w600,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),

//                       verticalSpace(5),

//                       Text(
//                         DateFormat(
//                           'dd MMM yyyy • hh:mm a',
//                         ).format(date),
//                         style: AppTextStyles.interGrey(
//                           11,
//                           FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String body;
  final DateTime date;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            color:isDark?AppColors.notificationCard: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:isDark?AppColors.whiteColor.withValues(alpha: 0.08): AppColors.blackColor.withValues(alpha: 0.08),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CustomCircleAvatar(
                  color: iconColor,
                  icon: icon,
                  iconColor: AppColors.whiteColor,
                ),

                horizontalSpace(12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 16.sp),
                      ),

                      verticalSpace(4),

                      Text(
                        body,
                        style: AppTextStyles.interGrey(12, FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      verticalSpace(5),

                      Text(
                        DateFormat('dd MMM yyyy • hh:mm a').format(date),
                        style: AppTextStyles.interGrey(11, FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
