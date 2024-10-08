import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqliteviewer/src/core/extension/string.dart';
import 'package:sqliteviewer/src/core/utils/print.dart';
import 'package:sqliteviewer/src/core/utils/show_toast.dart';
import 'package:sqliteviewer/src/features/app_dashboard/data/data_source/local_storage.dart';
import 'package:sqliteviewer/src/features/db_dashboard/presentation/screens/db_dashboard.dart';

part 'app_dashboard_state.dart';

class AppDashboardCubit extends Cubit<AppDashboardState> {
  AppDashboardCubit()
      : super(
          AppDashboardState(
            openedPaths: LocalStorageRepo.lastOpenedFiles(),
            isDragging: false,
          ),
        );

  void toggleDraggingState(bool isDragging) {
    emit(state.copyWith(isDragging: isDragging));
  }

  Future<bool> isValidDatabaseFile(String filePath) async {
    // Check if the file exists and has a .db extension
    if (!File(filePath).existsSync() || extension(filePath) != '.db') {
      return false;
    }

    try {
      // Try to open the database
      Database db = await openDatabase(filePath);

      // Try querying the database (e.g., fetching the list of tables)
      List<Map<String, dynamic>> result = await db
          .rawQuery('SELECT name FROM sqlite_master WHERE type="table"');

      // Close the database
      await db.close();

      // If querying the database succeeded, it's likely a valid database
      return result.isNotEmpty;
    } catch (e) {
      // If an error occurs, the file is not a valid SQLite database
      return false;
    }
  }

  Future<void> pickDatabaseFromFiles(
      GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      // Request storage permission
      if (!(await Permission.storage.request().isGranted ||
          await Permission.manageExternalStorage.request().isGranted)) {
        showToast("Allow app to read and write files",
            appToastStyle: AppToastStyle.error);
        return;
      }

      // Pick a file
      final result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result == null) return; // User canceled the picker

      final filePath = result.files.single.path!;
      if (await handleOpenedFile(filePath)) {
        // Safely access the context after checking if mounted
        final scaffoldContext = scaffoldKey.currentState?.context;
        if (scaffoldContext != null && scaffoldContext.mounted) {
          Navigator.push(scaffoldContext, DBDashboard.route(filePath));
        }
      }
    } catch (e) {
      // Handle errors
      showToast("An error occurred: ${e.toString()}",
          appToastStyle: AppToastStyle.error);
      appPrint(e);
    }
  }

  Future<bool> handleOpenedFile(String filePath) async {
    if (!await isValidDatabaseFile(filePath)) {
      showToast("Not supported file.\n${filePath.getFileName()}",
          appToastStyle: AppToastStyle.error);
      return false;
    }

    final List<String> openedPaths = LocalStorageRepo.lastOpenedFiles();

    final String selectedFilePath = filePath;
    if (state.openedPaths.contains(selectedFilePath)) {
      openedPaths.removeWhere((e) => e == selectedFilePath);
    }
    openedPaths.add(selectedFilePath);

    await LocalStorageRepo.setLastOpenedFiles(openedPaths);

    emit(state.copyWith(openedPaths: openedPaths));
    return true;
  }

  Future<void> deletePath(String pathToDelete) async {
    final List<String> openedPaths = LocalStorageRepo.lastOpenedFiles();
    openedPaths.removeWhere((e) => e == pathToDelete);
    await LocalStorageRepo.setLastOpenedFiles(openedPaths);
    appPrint(openedPaths);
    emit(state.copyWith(openedPaths: openedPaths));
  }

  Future updateLastOpenedFile() async {}
}
