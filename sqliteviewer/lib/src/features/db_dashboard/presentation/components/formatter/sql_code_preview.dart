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
              style: const TextStyle(color: Colors.blue),
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
          textSpans.addAll(processWord(char));
          isWord = false;
        } else if (isComment) {
          buffer += char;
          if (char == "\n") {
            textSpans.add(
              TextSpan(
                text: buffer,
                style: const TextStyle(color: Colors.brown),
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
                style: const TextStyle(color: Colors.amber),
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
