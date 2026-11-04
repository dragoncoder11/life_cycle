import 'package:flutter/material.dart';

class TextDirectionHelper {
  static TextDirection getDirection(
    String text, {
    TextDirection fallback = TextDirection.ltr,
  }) {
    for (final character in text.runes) {
      final char = String.fromCharCode(character);

      if (RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]')
          .hasMatch(char)) {
        return TextDirection.rtl;
      }

      if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        return TextDirection.ltr;
      }
    }

    return fallback;
  }
}