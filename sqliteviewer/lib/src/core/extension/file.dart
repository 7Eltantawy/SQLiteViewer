import 'dart:io';
import "package:path/path.dart";

extension FileExt on File {
  /// Get FIle name from its path
  String getFileName() {
    return basename(path);
  }
}
