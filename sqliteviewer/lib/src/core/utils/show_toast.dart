import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

enum AppToastStyle { normal, error }

void showToast(String text, {AppToastStyle? appToastStyle}) {
  switch (appToastStyle) {
    case null:
    case AppToastStyle.normal:
      _showToast(
        text,
      );
      break;
    case AppToastStyle.error:
      _showToast(
        text,
        background: Colors.redAccent,
        textColor: Colors.white,
      );
  }
}

void _showToast(String text, {Color? background, Color? textColor}) {
  showSimpleNotification(
    Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    background: background,
    position: NotificationPosition.bottom,
  );
}
