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
    this.colorSettings = SQLCodePreviewColorSettings.highContrast4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18),
          children: tokenize(text),
        ),
      ),
    );
  }

  static final englishText = RegExp(r'\w');

  List<TextSpan> tokenize(String text) {
    List<TextSpan> textSpans = [];

    // comment start with --
    bool isComment = false;
    // quoted text inside "" or ''
    bool isQuotedText = false;

    // other
    bool isWord = false;

    String buffer = "";

    for (var i = 0; i < text.length; i++) {
      final char = text[i];

      if (buffer == "") {
        if (char == "-") {
          isComment = true;
        } else if (char == "'" || char == '"') {
          isQuotedText = true;
        } else if (englishText.hasMatch(char)) {
          isWord = true;
        } else {
          textSpans.add(
            TextSpan(
              text: char,
              style: TextStyle(color: colorSettings.specialCharsColor),
            ),
          );
          continue;
        }
      }

      if (englishText.hasMatch(char)) {
        buffer += char;
      } else {
        if (isWord) {
          textSpans.addAll(processWord(buffer));
          buffer = "";
          textSpans.add(
            TextSpan(
              text: char,
              style: TextStyle(color: colorSettings.specialCharsColor),
            ),
          );
          isWord = false;
        } else if (isComment) {
          buffer += char;
          if (char == "\n") {
            textSpans.add(
              TextSpan(
                text: buffer,
                style: TextStyle(color: colorSettings.commentColor),
              ),
            );

            buffer = "";
            isComment = false;
          }
        } else if (isQuotedText) {
          buffer += char;
          if (buffer.length > 1 && buffer.trim()[0] == char) {
            textSpans.add(
              TextSpan(
                text: buffer,
                style: TextStyle(color: colorSettings.quotedColor),
              ),
            );
            buffer = "";
          }
        }
      }
    }

    return textSpans;
  }

  List<TextSpan> processWord(String word) {
    const TextStyle sharedStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    for (final String item in keywords) {
      if (word.toLowerCase().trim() == item.toLowerCase()) {
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
      if (word.toLowerCase().trim() == item.toLowerCase()) {
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
          element.value.map((e) => e).toList(),
        ),
    );
    for (final String item in flatten) {
      if (word.toLowerCase().trim() == item.toLowerCase()) {
        return [
          TextSpan(
            text: word,
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
  final Color quotedColor;
  final Color specialCharsColor;

  const SQLCodePreviewColorSettings({
    required this.keywordsColor,
    required this.tablesColor,
    required this.tablesColumnsColor,
    required this.commentColor,
    required this.quotedColor,
    required this.specialCharsColor,
  });

  // High Contrast Theme 1
  static const highContrast1 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.white,
    tablesColor: Colors.yellow,
    tablesColumnsColor: Colors.orange,
    commentColor: Colors.green,
    quotedColor: Colors.blue,
    specialCharsColor: Colors.red,
  );

  // High Contrast Theme 2
  static const highContrast2 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.cyan,
    tablesColor: Colors.purple,
    tablesColumnsColor: Colors.blue,
    commentColor: Colors.amber,
    quotedColor: Colors.teal,
    specialCharsColor: Colors.pink,
  );

  // High Contrast Theme 3
  static const highContrast3 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.green,
    tablesColor: Colors.red,
    tablesColumnsColor: Colors.yellow,
    commentColor: Colors.blue,
    quotedColor: Colors.purple,
    specialCharsColor: Colors.orange,
  );

  // High Contrast Theme 4
  static const highContrast4 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.orange,
    tablesColor: Colors.blue,
    tablesColumnsColor: Colors.pink,
    commentColor: Colors.teal,
    quotedColor: Colors.yellow,
    specialCharsColor: Colors.green,
  );

  // High Contrast Theme 5
  static const highContrast5 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.pink,
    tablesColor: Colors.green,
    tablesColumnsColor: Colors.amber,
    commentColor: Colors.cyan,
    quotedColor: Colors.red,
    specialCharsColor: Colors.blue,
  );
}
