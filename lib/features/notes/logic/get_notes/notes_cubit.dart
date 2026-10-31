import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:meta/meta.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());
  String?image;
  Set<NoteModel> selectedNotes = {};

  bool get isSelectionMode => selectedNotes.isNotEmpty;
  TextEditingController? title,describtion;
   List<NoteModel>? notes ;
  fetchNotes(){
    var notesBox=Hive.box<NoteModel>(kNotesBox);
    notes=notesBox.values.toList();
    emit(NotesSuccess());
  }
  // Select or unselect note
  void toggleNoteSelection(NoteModel note) {
    if (selectedNotes.contains(note)) {
      selectedNotes.remove(note);
    } else {
      selectedNotes.add(note);
    }

    emit(NotesSuccess());
  }

  // Delete selected notes
  Future<void> deleteSelectedNotes() async {
    final notesToDelete = selectedNotes.toList();

    for (var note in notesToDelete) {
      await note.delete();
    }

    selectedNotes.clear();

    fetchNotes();
  }

  // Clear selection
  void clearSelection() {
    selectedNotes.clear();
    emit(NotesSuccess());
  }

  // Check if note is selected
  bool isNoteSelected(NoteModel note) {
    return selectedNotes.contains(note);
  }
  
  @override
Future<void> close() {
  title?.dispose();
  describtion?.dispose();
  return super.close();
}

}
