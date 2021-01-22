import 'package:kotprog/db/sql.dart';
import 'package:kotprog/models/chat.dart';
import 'package:kotprog/models/message.dart';
import 'package:sqflite/sqlite_api.dart';

class DbAccess {
  final Sql sql;

  DbAccess({this.sql});

  // Chatek listájának betöltése
  Future<List<Chat>> loadChats() async {
    final Database database = await sql.database;
    List<Map<String, dynamic>> result = await database.query('chats');
    return List.generate(result.length, (i) {
      return Chat(
        id: result[i]['id'],
        title: result[i]['title'],
      );
    });
  }

  // Új chat hozzáadása
  Future<void> addChat(Chat chat) async {
    final Database database = await sql.database;
    await database.insert(
      'chats',
      chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Chat eltávolítása
  // TODO: Ennek használata
  Future<void> removeChat(Chat chat) async {
    final Database database = await sql.database;
    database.delete(
      'chats',
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  // Üzenetek listájának betöltése egy chaten belül
  Future<List<Message>> loadMessages(int chatId) async {
    final Database database = await sql.database;
    List<Map<String, dynamic>> result =
      await database.query(
        'messages',
        where: 'chatId = ?',
        whereArgs: [chatId],
      );
    return List.generate(result.length, (i) {
      return Message(
        id: result[i]['id'],
        chatId: result[i]['chatId'],
        sender: result[i]['sender'],
        content: result[i]['content'],
        timestamp: result[i]['timestamp'],
      );
    });
  }

  // Új üzenet hozzáadása, avagy elküldése
  Future<void> addMessage(Message msg) async {
    final Database database = await sql.database;
    await database.insert(
      'messages',
      msg.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Üzenet eltávolítása
  // TODO: Ennek használata
  Future<void> removeMessage(Message msg) async {
    final Database database = await sql.database;
    database.delete(
      'messages',
      where: 'id = ?',
      whereArgs: [msg.id],
    );
  }

}