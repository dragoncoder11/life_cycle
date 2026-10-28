import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/logic/get_notes/notes_cubit.dart';
import 'package:life_cycle/features/notes/view/widgets/note_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        var cubit=context.read<NotesCubit>();
        List<NoteModel> notes=cubit.notes??[];
        return ListView.builder(
          reverse: true,
          physics: BouncingScrollPhysics(),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteItem(noteModel: notes[index]);
          },
        );
      },
    );
  }
}
