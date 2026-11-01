import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncomeExtendCard extends StatelessWidget {
  final Color cardColor;
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final String title;
  final double price;
  final TextStyle titleStyle;
  final TextStyle priceStyle;
  final bool showViewAll;
  final VoidCallback? onViewAll;

  const IncomeExtendCard({
    super.key,
    required this.cardColor,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    required this.title,
    required this.price,
    required this.titleStyle,
    required this.priceStyle,
    this.showViewAll = false,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.r,
            backgroundColor: circleColor,
            child: Icon(
              icon,
              color: iconColor,
              size: 18.r,
            ),
          ),

          SizedBox(width: 6.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 3.h),

                Text(
                  '${price.toStringAsFixed(0)} EGP',
                  style: priceStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                if (showViewAll) ...[
                  SizedBox(height: 3.h),

                  GestureDetector(
                    onTap: onViewAll,
                    child: Text(
                      'View All',
                      style: titleStyle.copyWith(
                        fontSize: 10.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: titleStyle.color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}