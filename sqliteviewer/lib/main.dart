import 'package:flutter/material.dart';
import 'package:sqliteviewer/src/app.dart';
import 'package:sqliteviewer/src/services.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}
