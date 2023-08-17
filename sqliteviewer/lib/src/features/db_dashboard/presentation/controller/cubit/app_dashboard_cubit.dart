import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/features/app_dashboard/data/data_source/local_storage.dart';
import 'package:sqliteviewer/src/core/utils/show_toast.dart';

part 'app_dashboard_state.dart';

class AppDashboardCubit extends Cubit<AppDashboardState> {
  AppDashboardCubit()
      : super(
          AppDashboardState(openedPaths: LocalStorageRepo.lastOpenedFiles()),
        );

  Future<void> pickDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null) return;
    String filePath = result.files.single.path!;

    if (!filePath.endsWith('.db')) {
      showToast("Please select .db file");

      return;
    }

    final List<String> openedPaths = state.openedPaths;

    final String selectedFilePath = filePath;
    if (state.openedPaths.contains(selectedFilePath)) {
      state.openedPaths.removeWhere((e) => e == selectedFilePath);
    }
    state.openedPaths.add(selectedFilePath);

    await LocalStorageRepo.setLastOpenedFiles(openedPaths);

    emit(state.copyWith(openedPaths: openedPaths));
  }

  Future updateLastOpenedFile() async {}
}
