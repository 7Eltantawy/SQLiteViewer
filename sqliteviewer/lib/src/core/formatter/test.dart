import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({super.key});

  @override
  CustomInputFieldState createState() => CustomInputFieldState();
}

class CustomInputFieldState extends State<CustomInputField> {
  final TextEditingController _controller = TextEditingController();
  List<String> keywords = ['flutter', 'custom', 'input', 'color'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {}); // Trigger a rebuild on text change
          },
          decoration: const InputDecoration(labelText: 'Type something...'),
        ),
        const SizedBox(height: 10),
        const Text('Output:'),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16),
              children: _buildTextSpans(_controller.text),
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _buildTextSpans(String input) {
    List<TextSpan> textSpans = [];
    List<String> words = input.split(' ');

    for (String word in words) {
      bool isKeyword = false;

      if (keywords.contains(word.toLowerCase())) {
        isKeyword = true;
      }

      if (isKeyword) {
        textSpans.add(
          TextSpan(
            text: '$word '.toUpperCase(),
            style: const TextStyle(color: Colors.amber),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
