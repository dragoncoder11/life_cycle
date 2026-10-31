import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';

class IncomeExtendCard extends StatelessWidget {
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
  });
  final Color cardColor;
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final String title;
  final double price;
  final TextStyle titleStyle;
  final TextStyle priceStyle;

  @override
  Widget build(BuildContext context) {
    var queryWidth = MediaQuery.of(context).size.width;
 //   var queryHeight = MediaQuery.of(context).size.height;
    return Container(
      width: queryWidth * .4,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CustomCircleAvatar(
            radius: 18.r,
            icon: icon,
            iconSize: 24.r,
            color: circleColor,
            iconColor: iconColor,
          ),
          horizontalSpace(7),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              verticalSpace(4),
              Text('${price.toInt()} EGP', style: priceStyle),
            ],
          ),
        ],
      ),
    );
  }
}
