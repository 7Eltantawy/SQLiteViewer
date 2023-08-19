// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SQLCodePreview extends StatelessWidget {
  final String text;
  final List<String> keywords;
  final List<String> dataTypeKeywords;
  final Map<String, List<String>> tablesColumns;
  final SQLCodePreviewColorSettings colorSettings;

  const SQLCodePreview({
    super.key,
    required this.keywords,
    required this.dataTypeKeywords,
    required this.text,
    required this.tablesColumns,
    this.colorSettings = SQLCodePreviewColorSettings.colorScheme2,
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

    for (final String item in dataTypeKeywords) {
      if (word.toLowerCase().trim() == item.toLowerCase()) {
        return [
          TextSpan(
            text: word.toUpperCase(),
            style: sharedStyle.copyWith(
              color: colorSettings.dataTypeKeywords,
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
  final Color dataTypeKeywords;
  final Color tablesColor;
  final Color tablesColumnsColor;
  final Color commentColor;
  final Color quotedColor;
  final Color specialCharsColor;

  const SQLCodePreviewColorSettings({
    required this.keywordsColor,
    required this.dataTypeKeywords,
    required this.tablesColor,
    required this.tablesColumnsColor,
    required this.commentColor,
    required this.quotedColor,
    required this.specialCharsColor,
  });

  // High Contrast Theme 1
  static const highContrast1 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.white,
    dataTypeKeywords: Colors.yellow,
    tablesColor: Colors.orange,
    tablesColumnsColor: Colors.blue,
    commentColor: Colors.green,
    quotedColor: Colors.purple,
    specialCharsColor: Colors.red,
  );

  // High Contrast Theme 2
  static const highContrast2 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.green,
    dataTypeKeywords: Colors.purple,
    tablesColor: Colors.yellow,
    tablesColumnsColor: Colors.teal,
    commentColor: Colors.amber,
    quotedColor: Colors.blue,
    specialCharsColor: Colors.cyan,
  );

  // High Contrast Theme 3
  static const highContrast3 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.blue,
    dataTypeKeywords: Colors.orange,
    tablesColor: Colors.green,
    tablesColumnsColor: Colors.red,
    commentColor: Colors.pink,
    quotedColor: Colors.teal,
    specialCharsColor: Colors.amber,
  );

  // High Contrast Theme 4
  static const highContrast4 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.pink,
    dataTypeKeywords: Colors.blue,
    tablesColor: Colors.cyan,
    tablesColumnsColor: Colors.purple,
    commentColor: Colors.yellow,
    quotedColor: Colors.green,
    specialCharsColor: Colors.red,
  );

  // High Contrast Theme 5
  static const highContrast5 = SQLCodePreviewColorSettings(
    keywordsColor: Colors.yellow,
    dataTypeKeywords: Colors.green,
    tablesColor: Colors.purple,
    tablesColumnsColor: Colors.orange,
    commentColor: Colors.red,
    quotedColor: Colors.cyan,
    specialCharsColor: Colors.blue,
  );

  // Color Scheme 1
  static const colorScheme1 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF1976D2),
    dataTypeKeywords: Color(0xFF4CAF50),
    tablesColor: Color(0xFFF44336),
    tablesColumnsColor: Color(0xFF673AB7),
    commentColor: Color(0xFF9E9E9E),
    quotedColor: Color(0xFFFF9800),
    specialCharsColor: Color(0xFF607D8B),
  );

  // Color Scheme 2
  static const colorScheme2 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFFE91E63),
    dataTypeKeywords: Color(0xFF2196F3),
    tablesColor: Color(0xFF8BC34A),
    tablesColumnsColor: Color(0xFFFF5722),
    commentColor: Color(0xFF795548),
    quotedColor: Color(0xFF9C27B0),
    specialCharsColor: Color(0xFFCDDC39),
  );

  // Color Scheme 3
  static const colorScheme3 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF009688),
    dataTypeKeywords: Color(0xFFFFC107),
    tablesColor: Color(0xFF03A9F4),
    tablesColumnsColor: Color(0xFF8BC34A),
    commentColor: Color(0xFF9E9E9E),
    quotedColor: Color(0xFF673AB7),
    specialCharsColor: Color(0xFF607D8B),
  );

  // Color Scheme 4
  static const colorScheme4 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF673AB7),
    dataTypeKeywords: Color(0xFF4CAF50),
    tablesColor: Color(0xFF2196F3),
    tablesColumnsColor: Color(0xFFE91E63),
    commentColor: Color(0xFF9E9E9E),
    quotedColor: Color(0xFFFFC107),
    specialCharsColor: Color(0xFF795548),
  );

  // Color Scheme 10
  static const colorScheme10 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFFE57373),
    dataTypeKeywords: Color(0xFF81C784),
    tablesColor: Color(0xFF64B5F6),
    tablesColumnsColor: Color(0xFFF06292),
    commentColor: Color(0xFFB0BEC5),
    quotedColor: Color(0xFFFFD54F),
    specialCharsColor: Color(0xFFA1887F),
  );
}
