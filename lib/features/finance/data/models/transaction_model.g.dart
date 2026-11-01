import 'package:hive/hive.dart';
import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';
import 'package:life_cycle/features/finance/data/models/transaction_model.dart';

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 4;

  @override
  TransactionModel read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final amount = reader.readDouble();
    final type = reader.read() as TransactionType;
    final category = reader.read() as TransactionCategoryModel;
    final date = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final note = reader.readBool() ? reader.readString() : null;

    return TransactionModel(
      id: id,
      title: title,
      amount: amount,
      type: type,
      category: category,
      date: date,
      note: note,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.write(obj.type);
    writer.write(obj.category);
    writer.writeInt(obj.date.millisecondsSinceEpoch);

    writer.writeBool(obj.note != null);
    if (obj.note != null) {
      writer.writeString(obj.note!);
    }
  }
}