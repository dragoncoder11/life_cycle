import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:life_cycle/features/finance/data/models/transaction_category_model.dart';

class TransactionCategoryModelAdapter
    extends TypeAdapter<TransactionCategoryModel> {
  @override
  final int typeId = 2;

  @override
  TransactionCategoryModel read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final iconCodePoint = reader.readInt();
    final fontFamily = reader.readString();
    final iconColor = reader.readInt();

    return TransactionCategoryModel(
      id: id,
      name: name,
      icon: IconData(
        iconCodePoint,
        fontFamily: fontFamily,
      ),
      iconColor: Color(iconColor),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionCategoryModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeInt(obj.icon.codePoint);
    writer.writeString(obj.icon.fontFamily ?? 'MaterialIcons');
    writer.writeInt(obj.iconColor.toARGB32());
  }
}