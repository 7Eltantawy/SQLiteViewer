extension StringExt on String {
  /// Get FIle name from its path
  String getFileName() {
    return split("/").last;
  }
}
