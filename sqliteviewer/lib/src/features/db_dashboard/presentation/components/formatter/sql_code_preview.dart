import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';

class SQLCodePreview extends StatelessWidget {
  final String text;
  final List<String> keywords;
  final List<String> tables;
  final Map<String, List<String>> tablesColumns;
  final Color keywordsColor;
  final Color tablesColor;
  final Color tablesColumnsColor;

  const SQLCodePreview({
    super.key,
    required this.keywords,
    required this.text,
    required this.tables,
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
    appPrint(tablesColumns);

    List<TextSpan> textSpans = [];
    List<String> lines = input.split('\n');

    /// Each Line
    for (int lineIndex = 0; lineIndex < lines.length; lineIndex++) {
      String line = lines[lineIndex];
      List<String> words = line.split(' ');

      /// Each Word in line
      for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
        String word = words[wordIndex];

        textSpans.add(buildTextSpan(word));

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

  TextSpan buildTextSpan(String word) {
    String wordToSet = word;
    bool isKeyword = false;
    Color? textColor;

    for (final String item in keywords) {
      if (word.toLowerCase() == item.toLowerCase()) {
        isKeyword = true;
        textColor = keywordsColor;
        wordToSet = word.toUpperCase();
        break;
      }
    }

    if (!isKeyword) {
      for (final String item in tables) {
        if (word.toLowerCase() == item.toLowerCase()) {
          isKeyword = true;
          textColor = tablesColor;
          wordToSet = word.toUpperCase();
          break;
        }
      }
    }

    if (!isKeyword) {
      final flatten = tablesColumns.entries.fold(
        <String>[],
        (previousValue, element) => previousValue
          ..addAll(
            element.value.map((e) => "${element.key}.$e").toList(),
          ),
      );

      // appPrint(flatten);
      for (final String item in flatten) {
        if (word.toLowerCase() == item.toLowerCase()) {
          isKeyword = true;
          textColor = tablesColumnsColor;
          wordToSet = word;
          break;
        }
      }
    }

    const TextStyle sharedStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    if (isKeyword) {
      return TextSpan(
        text: wordToSet,
        style: sharedStyle.copyWith(
          color: textColor,
        ),
      );
    } else {
      return TextSpan(
        text: wordToSet,
        style: sharedStyle,
      );
    }
  }
}
