
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/home/data/models/home_card_model.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key, required this.homeCardModel, required this.onTap,
  });
final HomeCardModel homeCardModel;
final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: homeCardModel.color.withOpacity(.2),borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Icon(homeCardModel.icon,color: homeCardModel.color,size: 35.r,),
          verticalSpace(16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Text(homeCardModel.title,style: AppTextStyles.interBlack(14, FontWeight.bold),),
                        Icon(Icons.arrow_forward,color:homeCardModel.color ,)
              
          ],)
        ],),
        
      ),
    );
  }
}
