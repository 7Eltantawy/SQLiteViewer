// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SQLCodePreview extends StatelessWidget {
  final String text;
  final List<String> keywords;
  final List<String> dataTypeKeywords;
  final List<String> tableColumnsNames;
  final Map<String, List<String>> tablesColumns;
  final SQLCodePreviewColorSettings colorSettings;

  SQLCodePreview({
    super.key,
    required this.keywords,
    required this.dataTypeKeywords,
    required this.text,
    required this.tablesColumns,
    this.colorSettings = SQLCodePreviewColorSettings.colorScheme,
  }) : tableColumnsNames = tablesColumns.entries.fold(
          <String>[],
          (previousValue, element) => previousValue
            ..addAll(
              element.value.map((e) => e).toList(),
            ),
        );

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
    StringBuffer buffer = StringBuffer();
    bool isComment = false;
    bool isQuotedText = false;
    bool isWord = false;

    for (var i = 0; i < text.length; i++) {
      final char = text[i];

      if (buffer.isEmpty) {
        if (char == "-" && i + 1 < text.length && text[i + 1] == '-') {
          isComment = true;
          buffer.write('--');
          i++; // Skip the second '-' character
        } else if (char == "'" || char == '"') {
          isQuotedText = true;
          buffer.write(char);
        } else if (englishText.hasMatch(char)) {
          isWord = true;
          buffer.write(char);
        } else {
          textSpans.add(
            TextSpan(
              text: char,
              style: TextStyle(color: colorSettings.specialCharsColor),
            ),
          );
        }
      } else if (isWord && englishText.hasMatch(char)) {
        buffer.write(char);
      } else if (isWord) {
        textSpans.add(processWord(buffer.toString()));
        buffer.clear();
        textSpans.add(
          TextSpan(
            text: char,
            style: TextStyle(color: colorSettings.specialCharsColor),
          ),
        );
        isWord = false;
      } else if (isComment) {
        buffer.write(char);
        if (char == "\n") {
          textSpans.add(
            TextSpan(
              text: buffer.toString(),
              style: TextStyle(color: colorSettings.commentColor),
            ),
          );
          buffer.clear();
          isComment = false;
        }
      } else if (isQuotedText) {
        buffer.write(char);
        if (buffer.length > 1 && buffer.toString().trim()[0] == char) {
          textSpans.add(
            TextSpan(
              text: buffer.toString(),
              style: TextStyle(color: colorSettings.quotedColor),
            ),
          );
          buffer.clear();
          isQuotedText = false;
        }
      }
    }

    if (buffer.isNotEmpty) {
      if (isWord) {
        textSpans.add(processWord(buffer.toString()));
      } else if (isComment) {
        textSpans.add(
          TextSpan(
            text: buffer.toString(),
            style: TextStyle(color: colorSettings.commentColor),
          ),
        );
      } else if (isQuotedText) {
        textSpans.add(
          TextSpan(
            text: buffer.toString(),
            style: TextStyle(color: colorSettings.quotedColor),
          ),
        );
      }
    }

    return textSpans;
  }

  TextSpan processWord(String word) {
    const TextStyle sharedStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    for (final String item in dataTypeKeywords) {
      if (word.toLowerCase() == item.toLowerCase()) {
        return TextSpan(
          text: word.toUpperCase(),
          style: sharedStyle.copyWith(
            color: colorSettings.dataTypeKeywords,
          ),
        );
      }
    }

    for (final String item in tablesColumns.keys) {
      if (word.toLowerCase() == item.toLowerCase()) {
        return TextSpan(
          text: word,
          style: sharedStyle.copyWith(
            color: colorSettings.tablesColor,
          ),
        );
      }
    }

    for (final String item in tableColumnsNames) {
      if (word.toLowerCase() == item.toLowerCase()) {
        return TextSpan(
          text: word,
          style: sharedStyle.copyWith(
            color: colorSettings.tablesColumnsColor,
          ),
        );
      }
    }

    for (final String item in keywords) {
      if (word.toLowerCase().trim() == item.toLowerCase()) {
        return TextSpan(
          text: word.toUpperCase(),
          style: sharedStyle.copyWith(
            color: colorSettings.keywordsColor,
          ),
        );
      }
    }

    return TextSpan(
      text: word,
      style: sharedStyle,
    );
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

  static const colorScheme = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFFE91E63),
    dataTypeKeywords: Color(0xFF2196F3),
    tablesColor: Color(0xFF8BC34A),
    tablesColumnsColor: Color(0xFFFF5722),
    commentColor: Color(0xFF795548),
    quotedColor: Color(0xFF9C27B0),
    specialCharsColor: Color(0xFFCDDC39),
  );
}
