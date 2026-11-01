import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_categories_state.dart';

class TransactionCategoriesCubit extends Cubit<TransactionCategoriesState> {
  TransactionCategoriesCubit() : super(TransactionCategoriesInitial());
  String selectedType = 'Expense';
  String? selectedCategoryId;
  String amount = '';
  String note = '';
  DateTime selectedDate = DateTime.now();
 void changeType(String type) {
    selectedType = type;
    emit(ChangeIndex());
  }
  void changeBetweenCategories(String categoryId){
   selectedCategoryId=categoryId;
   emit(ChangeCategoriesIndex());
  }
   void changeAmount(String value) {
    amount = value;
  }

  void changeNote(String value) {
    note = value;
  }

  void changeDate(DateTime date) {
    selectedDate = date;
    emit(ChangeIndex());
  }

  void resetForm() {
    selectedType = 'Expense';
    selectedCategoryId = null;
    amount = '';
    note = '';
    selectedDate = DateTime.now();

    emit(ChangeIndex());
  }
}
