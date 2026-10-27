// import 'package:hive/hive.dart';
// part 'note_model.g.dart';

// @HiveType(typeId: 0)
// class NoteModel extends HiveObject {
//   @HiveField(0)
//   final String? image;

//   @HiveField(1)
//   final String title;

//   @HiveField(2)
//   final String content;

//   @HiveField(3)
//   final DateTime createdAt;

//   @HiveField(4)
//   final DateTime? updatedAt;

//   NoteModel({
//     this.image,
//     required this.title,
//     required this.content,
//     required this.createdAt,
//     this.updatedAt,
//   });
// }

import 'package:hive/hive.dart';

class NoteModel extends HiveObject {
  final String? image;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoteModel({
    this.image,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
  });
}