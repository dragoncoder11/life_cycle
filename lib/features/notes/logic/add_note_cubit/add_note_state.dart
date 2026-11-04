part of 'add_note_cubit.dart';

@immutable
sealed class AddNoteState {}

final class AddNoteInitial extends AddNoteState {}
final class AddNoteLoading extends AddNoteState {}
final class AddNoteSuccess extends AddNoteState {}
final class AddNoteFailure extends AddNoteState {
  final String errMessage;

  AddNoteFailure({required this.errMessage});
}
final class ChangeAutoValidate extends AddNoteState {}
final class AddNoteImageChanged extends AddNoteState {}
final class NotesImageRemoved extends AddNoteState {}

