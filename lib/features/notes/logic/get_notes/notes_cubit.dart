
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/view/widgets/search_text_helper.dart';
import 'package:meta/meta.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  String? image;

  Set<NoteModel> selectedNotes = {};

  TextEditingController searchController = TextEditingController();

  String? searchQuery = '';

  TextEditingController? title, describtion;

  List<NoteModel>? notes = [];
  List<NoteModel> allNotes = [];

  bool get isSelectionMode => selectedNotes.isNotEmpty;

  // Fetch Notes
   fetchNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    allNotes = notesBox.values.toList();

    searchNotes(searchController.text);
  }

  // Search Notes

void searchNotes(String query) {
  searchQuery = query.trim().toLowerCase();

  final normalizedQuery = searchQuery!
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  if (normalizedQuery.isEmpty) {
    notes = List.from(allNotes);
  } else {
    notes = allNotes.where((note) {
      final title = (note.title ?? '')
          .toLowerCase()
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      final description = (note.content ?? '')
          .toLowerCase()
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      return title.contains(normalizedQuery) ||
          description.contains(normalizedQuery);
    }).toList();
  }

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
    searchController.dispose();

    return super.close();
  }
}
