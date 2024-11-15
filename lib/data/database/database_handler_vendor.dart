import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wedding_organizer/data/models/decoration_models.dart';
import 'package:wedding_organizer/data/models/photographer_models.dart';
import 'package:wedding_organizer/data/models/wedding_bands.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;
  DatabaseHelper._init();
  factory DatabaseHelper() {
    return instance;
  }
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('wedding_organizer.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Decoration (
        dc_id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        deskripsi TEXT,
        harga_paket TEXT,
        sample TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Photographers (
        pt_id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        deskripsi TEXT,
        harga_paket TEXT,
        sample TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE MusicBand (
        mb_id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        deskripsi TEXT,
        harga_paket TEXT,
        sample TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Orders (
        order_id INTEGER PRIMARY KEY AUTOINCREMENT,
        vendor_id INTEGER NOT NULL,
        vendor_type TEXT NOT NULL,
        user_id INTEGER,
        tanggal_pesanan TEXT
      )
    ''');
  }

  Future<void> simpanPesanan(int vendorId, String vendorType, int userId) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('Orders', {
      'vendor_id': vendorId,
      'vendor_type': vendorType,
      'user_id': userId,
      'tanggal_pesanan': DateTime.now().toIso8601String(),
    });
  }

  Future<void> tambahDecoration(
      String nama, String deskripsi, String hargaPaket, List<String> sample) async {
    final db = await instance.database;
    final sampleJson = sample.join(',');

    await db.insert('Decoration', {
      'nama': nama,
      'deskripsi': deskripsi,
      'harga_paket': hargaPaket,
      'sample': sampleJson,
    });
  }

  Future<void> tambahPhotographer(
      String nama, String deskripsi, String hargaPaket, List<String> sample) async {
    final db = await instance.database;
    final sampleJson = sample.join(',');

    await db.insert('Photographers', {
      'nama': nama,
      'deskripsi': deskripsi,
      'harga_paket': hargaPaket,
      'sample': sampleJson,
    });
  }

  Future<void> tambahBand(
      String nama, String deskripsi, String hargaPaket, List<String> sample) async {
    final db = await instance.database;
    final sampleJson = sample.join(',');

    await db.insert('MusicBand', {
      'nama': nama,
      'deskripsi': deskripsi,
      'harga_paket': hargaPaket,
      'sample': sampleJson,
    });
  }
  Future<List<DecorationVendor>> getDecorations() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('Decoration');
    return List.generate(maps.length, (i) {
      return DecorationVendor.fromJson(maps[i]);
    });
  }

  Future<List<Photographer>> getPhotographers() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('Photographers');
    return List.generate(maps.length, (i) {
      return Photographer.fromJson(maps[i]);
    });
  }

  Future<List<WeddingBand>> getMusicBands() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('MusicBand');
    return List.generate(maps.length, (i) {
      return WeddingBand.fromJson(maps[i]);
    });
  }

}
