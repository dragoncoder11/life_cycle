import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_categories_state.dart';

class TransactionCategoriesCubit extends Cubit<TransactionCategoriesState> {
  TransactionCategoriesCubit() : super(TransactionCategoriesInitial());
  String selectedType = 'Expense';
  String? selectedCategoryId;
 void changeType(String type) {
    selectedType = type;
    emit(ChangeIndex());
  }
  void changeBetweenCategories(String categoryId){
   selectedCategoryId=categoryId;
   emit(ChangeCategoriesIndex());
  }
}
