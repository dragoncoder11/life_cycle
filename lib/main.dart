import 'package:flutter/material.dart';
import 'package:life_cycle/life_cycle.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en', null);
  runApp(const LifeCycle());
}
