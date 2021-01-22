import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Sql {
  Database _database;

  // Adatbáziskapcsolat létrehozása
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await openDatabase(
      join(
        await getDatabasesPath(), 'crossmessenger.db',
      ),
      version: 1, // Később ennek növelésével lehet frissíteni a db-t
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE chats(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT
        );
        ''');
        await db.execute('''
        CREATE TABLE messages(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          chatId INTEGER,
          sender TEXT,
          content TEXT,
          timestamp INTEGER
        );
        ''');
      },
    );
    return _database;
  }
}
