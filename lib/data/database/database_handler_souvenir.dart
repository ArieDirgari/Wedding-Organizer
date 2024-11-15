import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static final DatabaseHandler _instance = DatabaseHandler._internal();
  static Database? _database;
  DatabaseHandler._internal();
  factory DatabaseHandler() {
    return _instance;
  }
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE cart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      food_name TEXT,
      price REAL,
      rating REAL,
      url_image TEXT
      )
      ''');
  }

  Future<void> insertCartItem(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('cart', item);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return await db.query('cart');
  }

  Future<void> deleteCartItem(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
