import 'dart:io';

extension FileExt on File {
  /// Get FIle name from its path
  String getFileName() {
    return path.split("/").last;
  }
}
