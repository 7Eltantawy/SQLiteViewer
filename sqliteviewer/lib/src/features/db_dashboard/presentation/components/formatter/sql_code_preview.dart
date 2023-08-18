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
    this.colorSettings = SQLCodePreviewColorSettings.set01,
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

  const SQLCodePreviewColorSettings({
    required this.keywordsColor,
    required this.tablesColor,
    required this.tablesColumnsColor,
  });

  static const SQLCodePreviewColorSettings set01 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF5D6D7E),
    tablesColor: Color(0xFF3498DB),
    tablesColumnsColor: Color(0xFFE67E22),
  );
  static const SQLCodePreviewColorSettings set02 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF3772FF),
    tablesColor: Color(0xFF53D769),
    tablesColumnsColor: Color(0xFFFFD236),
  );
  static const SQLCodePreviewColorSettings set03 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF8E44AD),
    tablesColor: Color(0xFFC0392B),
    tablesColumnsColor: Color(0xFFD35400),
  );
  static const SQLCodePreviewColorSettings set04 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF2C3E50),
    tablesColor: Color(0xFF34495E),
    tablesColumnsColor: Color(0xFFBDC3C7),
  );
  static const SQLCodePreviewColorSettings set05 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF27AE60),
    tablesColor: Color(0xFF1ABC9C),
    tablesColumnsColor: Color(0xFFF39C12),
  );
  static const SQLCodePreviewColorSettings set06 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF9B59B6),
    tablesColor: Color(0xFF3498DB),
    tablesColumnsColor: Color(0xFFE74C3C),
  );
  static const SQLCodePreviewColorSettings set07 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFFF39C12),
    tablesColor: Color(0xFFD4AC0D),
    tablesColumnsColor: Color(0xFFE67E22),
  );
  static const SQLCodePreviewColorSettings set08 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF1E8449),
    tablesColor: Color(0xFF117A65),
    tablesColumnsColor: Color(0xFF148F77),
  );
  static const SQLCodePreviewColorSettings set09 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFFC0392B),
    tablesColor: Color(0xFFE74C3C),
    tablesColumnsColor: Color(0xFFC23616),
  );
  static const SQLCodePreviewColorSettings set10 = SQLCodePreviewColorSettings(
    keywordsColor: Color(0xFF34495E),
    tablesColor: Color(0xFFD4AC0D),
    tablesColumnsColor: Color(0xFF27AE60),
  );
}
