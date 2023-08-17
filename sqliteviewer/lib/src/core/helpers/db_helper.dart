import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;
  static String path = "";

  DatabaseHelper._internal();

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _openDB();
    return _database!;
  }

  Future<Database> _openDB() async {
    return await openDatabase(
      path,
    );
  }

  Future<void> close() async {
    final db = await database();
    await db.close();
    _database = null;
  }

  ///* Add methods for CRUD operations here

  Future<List<String>> getAllTables() async {
    final db = await database();

    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';",
    );
    return tables.map((row) => row['name'] as String).toList();
  }
}
