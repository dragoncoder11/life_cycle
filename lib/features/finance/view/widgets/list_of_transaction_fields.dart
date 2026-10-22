
import 'package:flutter/material.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';

class ListOfTransactionFields extends StatelessWidget {
  const ListOfTransactionFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(6),
          Text(
            'Amount',
            style: AppTextStyles.interBlack(16, FontWeight.w500),
          ),
          verticalSpace(6),
          CustomTextFormField(
            hintText: '0.00',
            maxLines: 1,
            prefixIcon: Icon(Icons.attach_money),
            textInputType: TextInputType.number,
          ),
          verticalSpace(6),
          Text(
            'Date',
            style: AppTextStyles.interBlack(16, FontWeight.w500),
          ),
          verticalSpace(6),
          CustomTextFormField(
            hintText: 'Select Date',
            maxLines: 1,
            prefixIcon: Icon(Icons.date_range),
            textInputType: TextInputType.datetime,
          ),
          verticalSpace(6),
    
          Row(
            children: [
              Text(
                'Note',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),
              Text(
                ' (Optional)',
                style: AppTextStyles.interGrey(14, FontWeight.w500),
              ),
            ],
          ),
          verticalSpace(6),
          CustomTextFormField(
            hintText: 'e.g taxi, restaurant...',
            maxLines: 3,
          ),
          verticalSpace(8),
          CustomButton(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'Save',
          ),
        ],
      ),
    );
  }
}
