import 'package:life_cycle/features/finance/data/models/transaction_model.dart';

class FinanceState {
  final double initialBalance;
  final bool isInitialBalanceSet;
  final bool isLoading;
  final List<TransactionModel> transactions;
  final DateTime selectedMonth;
  final TransactionType? visibleTransactionType;

  const FinanceState({
    required this.initialBalance,
    this.isInitialBalanceSet = false,
    this.isLoading = false,
    required this.transactions,
    required this.selectedMonth,
    this.visibleTransactionType,
  });

  FinanceState copyWith({
    double? initialBalance,
    bool? isInitialBalanceSet,
    bool? isLoading,
    List<TransactionModel>? transactions,
    DateTime? selectedMonth,
    TransactionType? visibleTransactionType,
    bool clearVisibleType = false,
  }) {
    return FinanceState(
      initialBalance: initialBalance ?? this.initialBalance,
      isInitialBalanceSet:
          isInitialBalanceSet ?? this.isInitialBalanceSet,
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      visibleTransactionType: clearVisibleType
          ? null
          : visibleTransactionType ?? this.visibleTransactionType,
    );
  }
}