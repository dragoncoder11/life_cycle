import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/home/data/models/prayer_model.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({super.key, required this.prayerModel});
final PrayerModel prayerModel;
  @override
  Widget build(BuildContext context) {
    var mediaQueryWidth=MediaQuery.of(context).size.width;
    return Container(
      height: 70.h,
      width: mediaQueryWidth*.16,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           Icon(prayerModel.prayerIcon, size: 24, color: prayerModel.prayerIconColor),
           Text(
            prayerModel.prayerName,
            style:AppTextStyles.interBlack( 9,FontWeight.w500),
          ),
           Text(
            prayerModel.prayerTime,
            style: AppTextStyles.interBlack( 10,FontWeight.bold),
          ),
        ],
      ),
    );
  }
}