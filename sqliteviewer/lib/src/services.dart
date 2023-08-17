import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
}
