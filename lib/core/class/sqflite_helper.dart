import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteRepository {
  static const String TABLE_NAME = 'notes';

  static Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            tags TEXT,
            reminder_time TEXT,
            is_pinned INTEGER
          )
        ''');
      },
    );
  }

  static Future<int> createNote(String title, String content, String? tags, String? reminderTime, bool isPinned) async {
    final db = await _getDatabase();
    return await db.insert(TABLE_NAME, {
      'title': title,
      'content': content,
      'tags': tags,
      'reminder_time': reminderTime,
      'is_pinned': isPinned ? 1 : 0,
    });
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await _getDatabase();
    return await db.query(TABLE_NAME);
  }

  static Future<int> updateNote(int id, String title, String content, String? tags, String? reminderTime, bool isPinned) async {
    final db = await _getDatabase();
    return await db.update(
      TABLE_NAME,
      {
        'title': title,
        'content': content,
        'tags': tags,
        'reminder_time': reminderTime,
        'is_pinned': isPinned ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteNote(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}


