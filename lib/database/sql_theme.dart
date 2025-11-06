import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlTheme {
  static final SqlTheme instance = SqlTheme._init();
  static Database? _database;
  SqlTheme._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filename) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filename);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE themes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isDark INTEGER
      )
    ''');
  }

  Future<void> saveTheme(bool isDark) async {
    final db = await instance.database;
    await db.delete('themes'); // ensures only one theme row
    await db.insert('themes', {'isDark': isDark ? 1 : 0});
  }

  Future<bool> getTheme() async {
    final db = await instance.database;
    final result = await db.query('themes');
    if (result.isNotEmpty) {
      return result.first['isDark'] == 1;
    }
    return false;
  }
}
