import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_cycle/core/helper/app_constants.dart';
import 'package:life_cycle/core/utils/simple_bloc_observer.dart';
import 'package:life_cycle/features/notes/data/models/note_model.dart';
import 'package:life_cycle/features/notes/data/models/note_model_adapter.dart';
import 'package:life_cycle/features/tasks/data/models/task_model.dart';
import 'package:life_cycle/life_cycle.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  await Hive.initFlutter();
  Bloc.observer=SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
   Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>(kTasksBox);

  runApp(const LifeCycle());
}
