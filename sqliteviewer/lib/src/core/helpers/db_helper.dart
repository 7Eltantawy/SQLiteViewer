import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> database(String path) async {
    if (_database != null) return _database!;
    _database = await _openDB(path);
    return _database!;
  }

  Future<Database> _openDB(String path) async {
    return await openDatabase(
      path,
    );
  }

  // Add methods for CRUD operations here
}
