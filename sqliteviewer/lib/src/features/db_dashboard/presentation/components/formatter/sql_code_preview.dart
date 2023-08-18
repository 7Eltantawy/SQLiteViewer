import 'package:flutter/material.dart';

class SQLCodePreview extends StatelessWidget {
  final String text;
  final List<String> keywords;
  final Map<String, List<String>> tablesColumns;
  final Color keywordsColor;
  final Color tablesColor;
  final Color tablesColumnsColor;

  const SQLCodePreview({
    super.key,
    required this.keywords,
    required this.text,
    this.keywordsColor = Colors.deepOrange,
    this.tablesColor = Colors.teal,
    this.tablesColumnsColor = Colors.amber,
    required this.tablesColumns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18),
          children: _buildTextSpans(text),
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String input) {
    List<TextSpan> textSpans = [];
    List<String> lines = input.split('\n');

    /// Each Line
    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      String line = lines[lineIndex];
      List<String> words = line.split(' ');

      /// Each Word in line
      for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
        String word = words[wordIndex];

        textSpans.addAll(buildTextSpan(word));

        // Add a space after each word, except the last word in the line
        if (wordIndex < words.length - 1) {
          textSpans.add(const TextSpan(text: ' '));
        }
      }

      // Add a newline after each line, except the last line
      if (lineIndex < lines.length - 1) {
        textSpans.add(const TextSpan(text: '\n'));
      }
    }

    return textSpans;
  }

  List<TextSpan> buildTextSpan(String word) {
    const TextStyle sharedStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    for (final String item in keywords) {
      if (word.toLowerCase() == item.toLowerCase()) {
        return [
          TextSpan(
            text: word.toUpperCase(),
            style: sharedStyle.copyWith(
              color: keywordsColor,
            ),
          )
        ];
      }
    }

    for (final String item in tablesColumns.keys) {
      if (word.toLowerCase() == item.toLowerCase()) {
        return [
          TextSpan(
            text: word.toUpperCase(),
            style: sharedStyle.copyWith(
              color: tablesColor,
            ),
          )
        ];
      }
    }

    final flatten = tablesColumns.entries.fold(
      <String>[],
      (previousValue, element) => previousValue
        ..addAll(
          element.value.map((e) => "${element.key}.$e").toList(),
        ),
    );
    for (final String item in flatten) {
      if (word.toLowerCase() == item.toLowerCase()) {
        return [
          TextSpan(
            text: word.split('.')[0].toUpperCase(),
            style: sharedStyle.copyWith(
              color: tablesColor,
            ),
          ),
          TextSpan(
            text: ".${word.split('.')[1]}",
            style: sharedStyle.copyWith(
              color: tablesColumnsColor,
            ),
          )
        ];
      }
    }

    return [
      TextSpan(
        text: word,
        style: sharedStyle,
      )
    ];
  }
}
