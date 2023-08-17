import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class LocalStorageRepo {
  static final box = GetStorage();
  static String lastOpenedFilesKey = 'lastOpenedFiles';

  static List<String> lastOpenedFiles() {
    String? saved = box.read<String>(lastOpenedFilesKey);
    if (saved != null) {
      final Map<String, dynamic> savedFilesMap = json.decode(saved);
      List<String> savedFiles = List<String>.from(savedFilesMap.keys);
      return savedFiles;
    } else {
      return [];
    }
  }

  static Future<void> setLastOpenedFiles(List<String> files) async {
    Map<String, dynamic> filesMap = {for (var file in files) file: true};
    final String filesString = json.encode(filesMap);
    await box.write(lastOpenedFilesKey, filesString);
  }
}
