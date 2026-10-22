
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/features/finance/view/widgets/picking_date_card.dart';

class PickDateContainer extends StatelessWidget {
  const PickDateContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PickingDateCard(
              title: 'Start Date',
              date: '1 Oct 2026',
            ),
            Container(
              width: 1.w,
              height: 40.h,
              color: AppColors.kPrimaryColor,
            ),
            PickingDateCard(
              title: 'End Date',
              date: '31 Oct 2026',
            ),
          ],
        ),
      ),
    );
  }
}
