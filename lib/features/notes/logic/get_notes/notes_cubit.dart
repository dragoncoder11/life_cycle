import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:meta/meta.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
   List<NoteModel>? notes ;
  fetchNotes(){
    var notesBox=Hive.box<NoteModel>(kNotesBox);
    notes=notesBox.values.toList();
    emit(NotesSuccess());
  }
}
