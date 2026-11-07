import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/home/data/models/home_card_model.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.homeCardModel,
    required this.onTap,
  });

  final HomeCardModel homeCardModel;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: homeCardModel.color.withOpacity(.2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              homeCardModel.icon,
              color: homeCardModel.color,
              size: 35.r,
            ),

            horizontalSpace(6),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          homeCardModel.title,
                          style:Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 16.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      horizontalSpace(5),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: homeCardModel.color,
                        size: 18.r,
                      ),
                    ],
                  ),

                  verticalSpace(6),

                  Text(
                    homeCardModel.subTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.interBlack(
                      11,
                      FontWeight.w500,
                    ).copyWith(
                      color: homeCardModel.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}