
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

class PickingDateCard extends StatelessWidget {
  const PickingDateCard({
    super.key, required this.title, required this.date,
  });
final String title;
final String date;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
    
          children: [
            Row(
              children: [
                CustomCircleAvatar(
                  radius: 16,
                  iconColor: AppColors.kPrimaryColor,
                  color: AppColors.kPrimaryColor
                      .withOpacity(.2),
                  icon: Icons.date_range,
                  iconSize: 20.r,
                ),
                horizontalSpace(4),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.interGrey(
                        9,
                        FontWeight.w500,
                      ),
                    ),
                    Text(
                      date,
                      style: AppTextStyles.interBlack(
                        11,
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
