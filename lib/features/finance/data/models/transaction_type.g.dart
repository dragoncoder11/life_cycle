import 'package:hive/hive.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 3;

  @override
  TransactionType read(BinaryReader reader) {
    switch (reader.readInt()) {
      case 0:
        return TransactionType.income;
      case 1:
        return TransactionType.expense;
      default:
        throw HiveError('Invalid TransactionType');
    }
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    writer.writeInt(obj.index);
  }
}