import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColoredTextFormatter extends TextInputFormatter {
  final List<String> keywords;

  ColoredTextFormatter(this.keywords);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText =
        TextSpan(children: _buildTextSpans(newValue.text)).toPlainText();

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }

  List<TextSpan> _buildTextSpans(String input) {
    List<TextSpan> textSpans = [];
    List<String> words = input.split(' ');

    for (String word in words) {
      bool isKeyword = false;
      Color? textColor;
      for (final String item in keywords) {
        if (word.toLowerCase() == item.toLowerCase()) {
          isKeyword = true;
          textColor = Colors.blue;
          break;
        }
      }

      if (isKeyword) {
        textSpans.add(
          TextSpan(
            text: '$word '.toUpperCase(),
            style: TextStyle(color: textColor),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(text: '$word '),
        );
      }
    }

    return textSpans;
  }
}
