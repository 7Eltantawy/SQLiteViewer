import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';
import 'package:sqliteviewer/src/core/utils/show_toast.dart';
import 'package:sqliteviewer/src/features/app_dashboard/presentation/controller/cubit/app_dashboard_cubit.dart';
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
        onPressed: () {
          context.read<AppDashboardCubit>().deletePath(dbPath);
        },
        icon: const Icon(Icons.delete),
      ),
      onTap: () async {
        final bool isExist = File(dbPath).existsSync();

        if (!isExist) {
          showToast(
            "Database Not Exist",
            appToastStyle: AppToastStyle.error,
          );
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
