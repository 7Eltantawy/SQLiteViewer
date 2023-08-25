import 'package:flutter/material.dart';

class DragFileCard extends StatelessWidget {
  const DragFileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(50),
      ),
      width: 400,
      height: 300,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.file_open,
            size: 100,
          ),
          Text(
            "Drop Your File Here",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
