import 'package:flutter/foundation.dart';

void appPrint(Object? object) {
  printColor('[APP] $object', color: PrintColors.green);
}

void printColor(Object? object, {int color = 0}) {
  final orangeText = '\u001b[${color}m$object\u001b[0m';
  if (kDebugMode) {
    print(orangeText);
  }
}

class PrintColors {
  static int black = 30;
  static int red = 31;
  static int green = 32;
  static int yellow = 33;
  static int blue = 34;
  static int magenta = 35;
  static int cyan = 36;
  static int white = 37;
}
