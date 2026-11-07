import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:life_cycle/core/helper/spacing.dart';
import 'package:life_cycle/core/theme/app_colors.dart';
import 'package:life_cycle/core/theme/app_text_styles.dart';
import 'package:life_cycle/core/widgets/custom_button.dart';
import 'package:life_cycle/core/widgets/custom_text_form_field.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_cubit.dart';
import 'package:life_cycle/features/finance/logic/cubit/transaction_categories_cubit.dart';
import 'package:life_cycle/features/finance/view/widgets/transaction_categories_list.dart';

class ListOfTransactionFields extends StatelessWidget {
  const ListOfTransactionFields({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child:
          BlocBuilder<TransactionCategoriesCubit, TransactionCategoriesState>(
            builder: (context, state) {
              final cubit = context.read<TransactionCategoriesCubit>();

              return Form(
                key: cubit.formKey,
                autovalidateMode: cubit.autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(6.h),

                    // Amount
                    Text(
                      'Amount',
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(fontSize: 15.sp),
                    ),

                    verticalSpace(6.h),

                    CustomTextFormField(
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: cubit.changeAmount,
                      hintText: '0.00',
                      prefixIcon: const Icon(Icons.attach_money),
                      filled: true,
                      validate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'field is required';
                        }

                        final amount = double.tryParse(value.trim());

                        if (amount == null || amount <= 0) {
                          return 'Please enter a valid amount';
                        }

                        return null;
                      },
                    ),

                    verticalSpace(6.h),

                    // Date
                    Text(
                      'Date',
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(fontSize: 15.sp),
                    ),

                    verticalSpace(6.h),

                    InkWell(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate:
                              cubit.selectedDate.isBefore(cubit.appStartDate)
                              ? cubit.appStartDate
                              : cubit.selectedDate,

                          firstDate: cubit.appStartDate,
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.kPrimaryColor,
                                  onPrimary: isDark
                                      ? AppColors.notificationCard
                                      : AppColors.whiteColor,
                                  onSurface: isDark
                                      ? AppColors.whiteColor
                                      : AppColors.darkGreenColor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
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
                          color: isDark
                              ? AppColors.notificationCard
                              : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isDark
                                ? AppColors.whiteColor.withOpacity(.2)
                                : AppColors.darkGreenColor.withOpacity(.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range),
                            SizedBox(width: 10.w),
                            Text(
                              DateFormat(
                                'dd MMM yyyy',
                              ).format(cubit.selectedDate),
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),

                    verticalSpace(6.h),

                    // Note
                    Row(
                      children: [
                        Text(
                          'Note',
                          style: Theme.of(
                            context,
                          ).textTheme.displaySmall?.copyWith(fontSize: 15.sp),
                        ),
                        Text(
                          ' (Optional)',
                          style: AppTextStyles.interGrey(14, FontWeight.w500),
                        ),
                      ],
                    ),

                    verticalSpace(6.h),

                    CustomTextFormField(
                      maxLines: null,
                      minLines: 3,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      onChanged: cubit.changeNote,
                      controller: cubit.noteController,
                      filled: true,
                      hintText: 'e.g taxi, restaurant...',
                    ),

                    verticalSpace(8.h),

                    CustomButton(
                      onTap: () async {
                        await _saveTransaction(context, cubit);
                      },
                      title: 'Save',
                    ),

                    verticalSpace(16.h),
                  ],
                ),
              );
            },
          ),
    );
  }

  Future<void> _saveTransaction(
    BuildContext context,
    TransactionCategoriesCubit cubit,
  ) async {
    // Validate Amount
    if (!cubit.formKey.currentState!.validate()) {
      cubit.changeAutoValidateMode();
      return;
    }
    if (cubit.selectedCategoryId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }
    // Validate Category
    if (cubit.selectedCategoryId == null) {
      cubit.changeAutoValidateMode();
      return;
    }

    final amount = double.parse(cubit.amount.trim());

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

    await context.read<FinanceCubit>().addTransaction(transaction);

    cubit.resetForm();

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
