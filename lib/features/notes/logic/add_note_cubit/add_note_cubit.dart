import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  // addNote(NoteModel note) async {
  //   emit(AddNoteLoading());
  //   try {
  //     var notesBox = Hive.box<NoteModel>(kNotesBox);
  //     await notesBox.add(note);
  //     emit(AddNoteSuccess());
  //   } catch (e) {
  //     emit(AddNoteFailure(errMessage: e.toString()));
  //   }
  // }
 Future<void> addNote(NoteModel note) async {
  emit(AddNoteLoading());

  try {
    final notesBox = Hive.box<NoteModel>(kNotesBox);

    final noteWithImage = NoteModel(
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      image: selectedImage?.path,
    );

    await notesBox.add(noteWithImage);

    selectedImage = null;

    emit(AddNoteSuccess());
  } catch (e) {
    emit(AddNoteFailure(errMessage: e.toString()));
  }
}

  changeAutoValidateMode() {
    autovalidateMode = AutovalidateMode.always;
    emit(ChangeAutoValidate());
  }

  @override
Future<void> close() {
  titleController.dispose();
  contentController.dispose();
  return super.close();
}

File? selectedImage;

final ImagePicker imagePicker = ImagePicker();

Future<void> pickImage(ImageSource source) async {
  try {
    final XFile? pickedImage = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedImage != null) {
      final directory = await getApplicationDocumentsDirectory();

      final extension = pickedImage.path.split('.').last;

      final imagePath =
          '${directory.path}/note_${DateTime.now().microsecondsSinceEpoch}.$extension';

      final savedImage = await File(pickedImage.path).copy(imagePath);

      selectedImage = savedImage;

      emit(AddNoteImageChanged());
    }
  } catch (e) {
    emit(AddNoteFailure(errMessage: e.toString()));
  }
}

void removeImage() {
  selectedImage = null;
  emit(AddNoteImageChanged());
}
}
