import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_circle_avatar.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/view/screens/add_balance_screen.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.balance});
  final double balance;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<FinanceCubit>(),
              child: const AddBalanceScreen(),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withOpacity(.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Balance',
                  style: AppTextStyles.interBlack(14, FontWeight.w500),
                ),
                verticalSpace(10),
                Text(
                  '${balance.toStringAsFixed(0)} EGP',
                  style: AppTextStyles.interBlack(20, FontWeight.bold),
                ),
              ],
            ),
            CustomCircleAvatar(
              radius: 28.r,
              icon: Icons.wallet,
              iconSize: 32.r,
              color: AppColors.income,
            ),
          ],
        ),
      ),
    );
  }
}
