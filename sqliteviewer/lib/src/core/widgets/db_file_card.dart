import 'package:flutter/material.dart';

class DBFileCard extends StatelessWidget {
  final String path;
  const DBFileCard({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.storage,
        size: 40,
      ),
      title: Text(
        path.split("/").last,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      subtitle: Text(path),
      onTap: () {},
    );
  }
}
