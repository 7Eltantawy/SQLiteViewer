import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String text;
  final Map<String, Color> keywords;
  const CustomInputField(
      {super.key, required this.keywords, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: RichText(
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
      for (final MapEntry<String, Color> item in keywords.entries) {
        if (word.toLowerCase() == item.key.toLowerCase()) {
          isKeyword = true;
          textColor = item.value;
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
