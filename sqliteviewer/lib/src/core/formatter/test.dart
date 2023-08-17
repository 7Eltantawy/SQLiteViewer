import 'package:flutter/material.dart';

class SQLCodePreview extends StatelessWidget {
  final String text;
  final List<String> keywords;
  const SQLCodePreview({
    super.key,
    required this.keywords,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: const TextStyle(fontSize: 16),
          children: _buildTextSpans(text),
        ),
      ),
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
