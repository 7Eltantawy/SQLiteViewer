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

  Future<List<Map<String, dynamic>>> getTableContent(String tableName) async {
    final db = await database();

    return await db.rawQuery("SELECT * FROM $tableName");
  }

  Future<List<Map<String, dynamic>>> getTableContentForSelectedColumns(
    String tableName,
    List<String> columns,
  ) async {
    final db = await database();

    return await db.query(tableName, columns: columns);
  }

  Future<List<Map<String, dynamic>>> getColumnNames(String tableName) async {
    final db = await database();

    return await db.rawQuery('PRAGMA table_info($tableName)');
  }

  Future<List<Map<String, dynamic>>> query(String query) async {
    final db = await database();

    final maps = await db.rawQuery(
      query,
    );

    return maps;
  }
}
