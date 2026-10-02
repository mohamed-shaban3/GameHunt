import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'game_hunt.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // جدول المفضلة
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            background_image TEXT,
            rating REAL,
            released TEXT
          )
        ''');

        // جدول الإشعارات
        await db.execute('''
          CREATE TABLE notifications (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            body TEXT NOT NULL,
            game_id INTEGER,
            created_at TEXT NOT NULL,
            is_read INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  // 1. الإضافة
  Future<int> insert(String table, Map<String, dynamic> values) async {
    final dbClient = await db;
    return await dbClient.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. الاستعلام / الجلب (يدعم الترتيب والشروط)
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    final dbClient = await db;
    return await dbClient.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  // اسم بديل لجلب البيانات لعدم كسر أي كود قديم يدعو getData
  Future<List<Map<String, dynamic>>> getData(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    return await query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  // 3. التحديث
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final dbClient = await db;
    return await dbClient.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // 4. الحذف (يدعم الحذف بالمعرف أو حذف الكل)
  Future<int> delete(
    String table, [
    String? where,
    List<dynamic>? whereArgs,
  ]) async {
    final dbClient = await db;
    return await dbClient.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
}