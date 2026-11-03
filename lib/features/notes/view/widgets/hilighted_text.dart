
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? style;
  final int? maxLines;
  final bool showMatchContext;
  final Color highlightColor;

  const HighlightedText({
    super.key,
    required this.text,
    required this.query,
    this.style,
    this.maxLines,
    this.showMatchContext = false,
    this.highlightColor = Colors.amber,
  });

  String normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = normalize(query);

    if (searchQuery.isEmpty || text.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    // Normalize text and keep original character positions.
    final normalizedText = StringBuffer();
    final originalIndexes = <int>[];

    bool previousWasSpace = false;

    for (int i = 0; i < text.length; i++) {
      final character = text[i];

      if (RegExp(r'\s').hasMatch(character)) {
        if (!previousWasSpace && normalizedText.isNotEmpty) {
          normalizedText.write(' ');
          originalIndexes.add(i);
        }

        previousWasSpace = true;
      } else {
        normalizedText.write(character.toLowerCase());
        originalIndexes.add(i);
        previousWasSpace = false;
      }
    }

    final searchableText = normalizedText.toString();

    // Find first match.
    final matchIndex = searchableText.indexOf(searchQuery);

    if (matchIndex == -1) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }

    final originalStart = originalIndexes[matchIndex];

    final originalEnd =
        originalIndexes[matchIndex + searchQuery.length - 1] + 1;

    // Select a small snippet around the match.
    int displayStart = 0;
    int displayEnd = text.length;

    if (showMatchContext) {
      const contextLength = 25;

      displayStart = (originalStart - contextLength)
          .clamp(0, text.length);

      displayEnd = (originalEnd + contextLength)
          .clamp(0, text.length);
    }

    final spans = <TextSpan>[];

    if (displayStart > 0) {
      spans.add(const TextSpan(text: '... '));
    }

    if (displayStart < originalStart) {
      spans.add(
        TextSpan(
          text: text.substring(displayStart, originalStart),
        ),
      );
    }

    // Highlight searched word.
    spans.add(
      TextSpan(
        text: text.substring(originalStart, originalEnd),
        style: TextStyle(
          color: highlightColor,
          fontWeight: FontWeight.bold,
          backgroundColor: highlightColor.withValues(alpha: 0.2),
        ),
      ),
    );

    if (originalEnd < displayEnd) {
      spans.add(
        TextSpan(
          text: text.substring(originalEnd, displayEnd),
        ),
      );
    }

    if (displayEnd < text.length) {
      spans.add(const TextSpan(text: ' ...'));
    }

    return Text.rich(
      TextSpan(
        style: style,
        children: spans,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
