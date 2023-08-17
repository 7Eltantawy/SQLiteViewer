import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColoredTextFormatter extends TextInputFormatter {
  final Map<String, Color> keywordColors;

  ColoredTextFormatter(this.keywordColors);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final List<TextSpan> textSpans = [];
    final List<String> words = newValue.text.split(' ');

    for (String word in words) {
      Color? textColor; // Default color

      for (String keyword in keywordColors.keys) {
        if (word.toLowerCase() == keyword.toLowerCase()) {
          textColor = keywordColors[keyword]!;
          break;
        }
      }

      textSpans.add(
        TextSpan(
          text: '$word ',
          style: TextStyle(color: textColor),
        ),
      );
    }

    final newText = TextSpan(children: textSpans).toPlainText();

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}
