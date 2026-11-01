import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_state.dart';

class MonthFilter extends StatelessWidget {
  const MonthFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceCubit, FinanceState>(
      builder: (context, state) {
        final cubit = context.read<FinanceCubit>();

        // Normalize selected month
        final selectedMonth = DateTime(
          state.selectedMonth.year,
          state.selectedMonth.month,
        );

        // Normalize available months
        final months = cubit.availableMonths
            .map((month) => DateTime(month.year, month.month))
            .toList();

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 4.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withOpacity(.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(selectedMonth),
                style: AppTextStyles.interBlack(
                  15,
                  FontWeight.w600,
                ),
              ),

              DropdownButton<DateTime>(
                value: selectedMonth,
                underline: const SizedBox(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.kPrimaryColor,
                ),
                items: months.map((month) {
                  return DropdownMenuItem<DateTime>(
                    value: month,
                    child: Text(
                      DateFormat('MMMM yyyy').format(month),
                      style: AppTextStyles.interBlack(
                        13,
                        FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (month) {
                  if (month != null) {
                    cubit.selectMonth(month);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}