import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {

  static final DBService instance = DBService._init();
  static Database? _database;

  DBService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        text TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
  }
}
