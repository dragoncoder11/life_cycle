import 'package:flutter/material.dart';

/// Central color palette for the MyLife app.
/// Use AppColors instead of hard-coding colors throughout the UI.
class AppColors {
  AppColors._();

  // Brand
  static const Color kPrimaryColor = Color(0xFF16856F);
  // static const Color primaryDark = Color.fromARGB(255, 2, 48, 42);
  static const Color primaryDark = Color(0xFF02302A);
  static const Color primaryLight = Color(0xFF45B89A);
  static const Color primarySoft = Color(0xFFDDF4E9);
  static const Color accent = Color(0xFFFFC247);

  // Backgrounds and surfaces
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFF0F7F3);
  static const Color mintBackground = Color(0xFFE6F6EC);
  static const Color inputBackground = Color(0xFFF8FAF9);

  // Text
  static const Color textPrimary = Color(0xFF1D2926);
  static const Color textSecondary = Color(0xFF6F7D78);
  static const Color textHint = Color(0xFFA1ACA7);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Borders and dividers
  static const Color border = Color(0xFFE1E9E4);
  static const Color divider = Color(0xFFEBF0ED);
  static const Color disabled = Color(0xFFD5DEDA);

  // Finance
  static const Color income = Color(0xFF35A982);
  static const Color incomeBackground = Color(0xFFE2F6EC);
  static const Color expense = Color(0xFFE96B78);
  static const Color expenseBackground = Color(0xFFFFE9EC);
  static const Color balance = Color(0xFF16856F);
  static const Color financeYellow = Color(0xFFFFC247);
  static const Color financeYellowBackground = Color(0xFFFFF3D6);
  static const Color transport = Color(0xFF4CA9A0);
  static const Color bills = Color(0xFF8A91A8);
  static const Color food = Color(0xFFF4B84A);

  // Tasks and notes
  static const Color task = Color(0xFF7B83E8);
  static const Color taskBackground = Color(0xFFEBECFF);
  static const Color notes = Color(0xFFE9AD43);
  static const Color notesBackground = Color(0xFFFFF2D8);
  static const Color reminder = Color(0xFF4D9FE6);
  static const Color reminderBackground = Color(0xFFE7F3FF);

  // Status and notifications
  static const Color success = Color(0xFF2EAA78);
  static const Color successBackground = Color(0xFFE2F6EC);
  static const Color warning = Color(0xFFF2AD3D);
  static const Color warningBackground = Color(0xFFFFF3D6);
  static const Color error = Color(0xFFD94F5C);
  static const Color errorBackground = Color(0xFFFFE9EC);
  static const Color info = Color(0xFF438FD0);
  static const Color infoBackground = Color(0xFFE7F3FF);

  // Navigation and controls
  static const Color navSelected = Color(0xFF16856F);
  static const Color navUnselected = Color(0xFF89958F);
  static const Color switchTrackOff = Color(0xFFD5DEDA);
  static const Color iconBackground = Color(0xFFEAF5EF);

  // Overlay
  static const Color overlay = Color(0x66000000);
}
