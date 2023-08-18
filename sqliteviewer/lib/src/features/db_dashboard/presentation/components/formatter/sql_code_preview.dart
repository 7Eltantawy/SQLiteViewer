// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SQLCodePreview extends StatelessWidget {
  final String text;
  final List<String> keywords;
  final Map<String, List<String>> tablesColumns;
  final SQLCodePreviewColorSettings colorSettings;

  const SQLCodePreview({
    super.key,
    required this.keywords,
    required this.text,
    required this.tablesColumns,
    this.colorSettings = SQLCodePreviewColorSettings.customTheme,
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

      if (line.startsWith("--")) {
        textSpans.add(
          TextSpan(
              text: line, style: TextStyle(color: colorSettings.commentColor)),
        );
      } else {
        /// Each Word in line
        for (int wordIndex = 0; wordIndex < words.length; wordIndex++) {
          String word = words[wordIndex];

          textSpans.addAll(buildTextSpan(word));

          // Add a space after each word, except the last word in the line
          if (wordIndex < words.length - 1) {
            textSpans.add(const TextSpan(text: ' '));
          }
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
              color: colorSettings.keywordsColor,
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
              color: colorSettings.tablesColor,
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
              color: colorSettings.tablesColor,
            ),
          ),
          TextSpan(
            text: ".${word.split('.')[1]}",
            style: sharedStyle.copyWith(
              color: colorSettings.tablesColumnsColor,
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

class SQLCodePreviewColorSettings {
  final Color keywordsColor;
  final Color tablesColor;
  final Color tablesColumnsColor;
  final Color commentColor;

  const SQLCodePreviewColorSettings({
    required this.keywordsColor,
    required this.tablesColor,
    required this.tablesColumnsColor,
    required this.commentColor,
  });

  // Static fields for common color presets
  static const SQLCodePreviewColorSettings darkTheme =
      SQLCodePreviewColorSettings(
    keywordsColor: Colors.blue,
    tablesColor: Colors.purple,
    tablesColumnsColor: Colors.teal,
    commentColor: Colors.grey,
  );

  static const SQLCodePreviewColorSettings lightTheme =
      SQLCodePreviewColorSettings(
    keywordsColor: Colors.black,
    tablesColor: Colors.blue,
    tablesColumnsColor: Colors.blueAccent,
    commentColor: Colors.green,
  );

  static const SQLCodePreviewColorSettings customTheme =
      SQLCodePreviewColorSettings(
    keywordsColor: Colors.orange,
    tablesColor: Colors.pink,
    tablesColumnsColor: Colors.red,
    commentColor: Colors.grey,
  );

  static const SQLCodePreviewColorSettings monochromeTheme =
      SQLCodePreviewColorSettings(
    keywordsColor: Colors.black,
    tablesColor: Colors.black,
    tablesColumnsColor: Colors.black,
    commentColor: Colors.black,
  );

  static const SQLCodePreviewColorSettings retroTheme =
      SQLCodePreviewColorSettings(
    keywordsColor: Colors.yellow,
    tablesColor: Colors.brown,
    tablesColumnsColor: Colors.orange,
    commentColor: Colors.green,
  );
}
