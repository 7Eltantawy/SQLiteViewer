import 'package:path/path.dart';

extension StringExt on String {
  /// Get FIle name from its path
  String getFileName() {
    return basename(this);
  }
}
