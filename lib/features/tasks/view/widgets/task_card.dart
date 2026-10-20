import 'package:flutter/material.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.kPrimaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .55,
                          child: Text(
                            'Finish the app design',
                            style: AppTextStyles.interBlack(
                              18,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                        verticalSpace(6),
                        Row(
                          children: [
                            Icon(Icons.date_range),
                            horizontalSpace(8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .55,

                              child: Text(
                                '06:00 AM',
                                style: AppTextStyles.interGrey(
                                  12,
                                  FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.more_vert),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
