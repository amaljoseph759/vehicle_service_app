// lib/core/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'services.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE services(id INTEGER PRIMARY KEY AUTOINCREMENT, service TEXT, time TEXT)',
        );
        await db.execute(
          'CREATE TABLE vehicles(id INTEGER PRIMARY KEY AUTOINCREMENT, plate TEXT, vin TEXT, brand TEXT, model TEXT, year TEXT)',
        );
      },
    );
  }
}
