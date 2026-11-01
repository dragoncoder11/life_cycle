import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';

import 'package:life_cycle/features/finance/data/models/transaction_model.dart';
import 'package:life_cycle/features/finance/logic/cubit/finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  late final Future<void> _loadFuture;

  FinanceCubit()
      : super(
          FinanceState(
            initialBalance: 0,
            transactions: [],
            selectedMonth: DateTime(
              DateTime.now().year,
              DateTime.now().month,
            ),
          ),
        ) {
    _loadFuture = _loadFinanceData();
  }

  // Load saved data from Hive
  Future<void> _loadFinanceData() async {
    final transactionsBox = Hive.box<TransactionModel>(kTransactionsBox);
    final financeBox = Hive.box<double>(kInitialBalanceBox);

    final transactions = transactionsBox.values.toList();
    final initialBalance =
        financeBox.get('initialBalance', defaultValue: 0.0) ?? 0.0;

    if (isClosed) return;

    emit(
      state.copyWith(
        initialBalance: initialBalance,
        transactions: transactions,
      ),
    );
  }

  // Current Balance
  double get currentBalance {
    double income = 0;
    double expenses = 0;

    for (final transaction in state.transactions) {
      if (transaction.type == TransactionType.income) {
        income += transaction.amount;
      } else {
        expenses += transaction.amount;
      }
    }

    return state.initialBalance + income - expenses;
  }

  // Transactions of selected month
  List<TransactionModel> get selectedMonthTransactions {
    return state.transactions.where((transaction) {
      return transaction.date.year == state.selectedMonth.year &&
          transaction.date.month == state.selectedMonth.month;
    }).toList();
  }

  // Monthly Income
  double get monthlyIncome {
    return selectedMonthTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // Monthly Expenses
  double get monthlyExpenses {
    return selectedMonthTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // Net Savings
  double get netSavings => monthlyIncome - monthlyExpenses;

  // Spending Rate
  double? get spendingRate {
    if (monthlyIncome == 0) return null;

    return (monthlyExpenses / monthlyIncome) * 100;
  }

  // Available Months
  List<DateTime> get availableMonths {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);

    final months = <DateTime>[currentMonth];

    for (final transaction in state.transactions) {
      final month = DateTime(
        transaction.date.year,
        transaction.date.month,
      );

      if (month.isAfter(currentMonth)) continue;

      final alreadyExists = months.any(
        (m) => m.year == month.year && m.month == month.month,
      );

      if (!alreadyExists) {
        months.add(month);
      }
    }

    months.sort((a, b) => b.compareTo(a));

    return months;
  }

  // Transactions displayed after View All
  List<TransactionModel> get visibleTransactions {
    final type = state.visibleTransactionType;

    if (type == null) return [];

    return selectedMonthTransactions
        .where((transaction) => transaction.type == type)
        .toList();
  }

  // Check if month has transactions of a specific type
  bool hasTransactionsOfType(TransactionType type) {
    return selectedMonthTransactions.any(
      (transaction) => transaction.type == type,
    );
  }

  // Set Initial Balance
  Future<void> setInitialBalance(double amount) async {
    await _loadFuture;

    if (isClosed) return;

    final financeBox = Hive.box<double>(kInitialBalanceBox);

    await financeBox.put('initialBalance', amount);

    if (isClosed) return;

    emit(state.copyWith(initialBalance: amount));
  }

  // Add Transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await _loadFuture;

    if (isClosed) return;final transactionsBox = Hive.box<TransactionModel>(kTransactionsBox);

    await transactionsBox.add(transaction);

    if (isClosed) return;

    final updatedTransactions = [
      ...state.transactions,
      transaction,
    ];

    emit(
      state.copyWith(
        transactions: updatedTransactions,
        clearVisibleType: true,
      ),
    );
  }

  // Select Month
  void selectMonth(DateTime month) {
    emit(
      state.copyWith(
        selectedMonth: DateTime(month.year, month.month),
        clearVisibleType: true,
      ),
    );
  }

  // Current Month Transactions
  List<TransactionModel> get currentMonthTransactions {
    return selectedMonthTransactions;
  }

  // Show / Hide Transactions
  void toggleTransactions(TransactionType type) {
    if (state.visibleTransactionType == type) {
      emit(state.copyWith(clearVisibleType: true));
    } else {
      emit(state.copyWith(visibleTransactionType: type));
    }
  }
}