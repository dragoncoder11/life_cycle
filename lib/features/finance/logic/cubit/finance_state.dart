import 'package:life_cycle/features/finance/data/models/transaction_model.dart';

class FinanceState {
  final double initialBalance;
  final List<TransactionModel> transactions;
  final DateTime selectedMonth;
  final TransactionType? visibleTransactionType;

  const FinanceState({
    required this.initialBalance,
    required this.transactions,
    required this.selectedMonth,
    this.visibleTransactionType,
  });

  FinanceState copyWith({
    double? initialBalance,
    List<TransactionModel>? transactions,
    DateTime? selectedMonth,
    TransactionType? visibleTransactionType,
    bool clearVisibleType = false,
  }) {
    return FinanceState(
      initialBalance: initialBalance ?? this.initialBalance,
      transactions: transactions ?? this.transactions,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      visibleTransactionType: clearVisibleType
          ? null
          : visibleTransactionType ?? this.visibleTransactionType,
    );
  }
}