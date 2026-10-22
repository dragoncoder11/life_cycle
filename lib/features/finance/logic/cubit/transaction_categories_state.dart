part of 'transaction_categories_cubit.dart';

@immutable
sealed class TransactionCategoriesState {}

final class TransactionCategoriesInitial extends TransactionCategoriesState {}
final class ChangeIndex extends TransactionCategoriesState {}
final class ChangeCategoriesIndex extends TransactionCategoriesState {}

