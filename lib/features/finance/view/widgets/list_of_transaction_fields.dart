import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_categories_list.dart';

class ListOfTransactionFields extends StatelessWidget {
  const ListOfTransactionFields({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<TransactionCategoriesCubit,
          TransactionCategoriesState>(
        builder: (context, state) {
          final cubit = context.read<TransactionCategoriesCubit>();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(6.h),

              Text(
                'Amount',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),

              verticalSpace(6.h),

              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: cubit.changeAmount,
                decoration: InputDecoration(
                  hintText: '0.00',
                  prefixIcon: const Icon(Icons.attach_money),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),

              verticalSpace(6.h),

              Text(
                'Date',
                style: AppTextStyles.interBlack(16, FontWeight.w500),
              ),

              verticalSpace(6.h),

              InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: cubit.selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    cubit.changeDate(pickedDate);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.textPrimary.withOpacity(.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      SizedBox(width: 10.w),
                      Text(
                        DateFormat('dd MMM yyyy').format(cubit.selectedDate),
                        style: AppTextStyles.interBlack(
                          14,
                          FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              verticalSpace(6.h),

              Row(children: [
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

              verticalSpace(6.h),

              TextFormField(
                maxLines: 3,
                onChanged: cubit.changeNote,
                decoration: InputDecoration(
                  hintText: 'e.g taxi, restaurant...',
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),

              verticalSpace(8.h),

              CustomButton(
                onTap: () {
                  _saveTransaction(context, cubit);
                },
                title: 'Save',
              ),

              verticalSpace(16.h),
            ],
          );
        },
      ),
    );
  }

  void _saveTransaction(
    BuildContext context,
    TransactionCategoriesCubit cubit,
  ) {
    final amount = double.tryParse(cubit.amount);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
        ),
      );
      return;
    }

    if (cubit.selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
        ),
      );
      return;
    }

    final categories = cubit.selectedType == 'Income'
        ? TransactionCategories.incomesCategories
        : TransactionCategories.expensesCategories;

    final selectedCategory = categories.firstWhere(
      (category) => category.id == cubit.selectedCategoryId,
    );

    final transaction = TransactionModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: selectedCategory.name,
      amount: amount,
      type: cubit.selectedType == 'Income'
          ? TransactionType.income
          : TransactionType.expense,
      category: selectedCategory,
      date: cubit.selectedDate,
      note: cubit.note.trim().isEmpty ? null : cubit.note.trim(),
    );

    context.read<FinanceCubit>().addTransaction(transaction);

    cubit.resetForm();

    Navigator.pop(context);
  }
}