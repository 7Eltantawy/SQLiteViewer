import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';
import 'package:sqliteviewer/src/core/utils/show_toast.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_dashboard.dart';

class DBFileCard extends StatelessWidget {
  final String dbPath;
  const DBFileCard({super.key, required this.dbPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.storage,
        size: 40,
      ),
      title: Text(
        dbPath.getFileName(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      subtitle: Text(dbPath),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.delete),
      ),
      onTap: () async {
        final bool isExist = File(dbPath).existsSync();

        if (!isExist) {
          showToast("Database Not Exist");
          return;
        }

        Navigator.push(
          context,
          DBDashboard.route(dbPath),
        );
      },
    );
  }
}
