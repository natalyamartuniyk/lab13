import 'package:sqflite/sqflite.dart';
import '../models/note_model.dart';
import '../service/db.dart';

class NotesRepo {

  Future<void> addNote(Note note) async {
    final db = await DBService.instance.database;

    await db.rawInsert(
      'INSERT INTO notes(text, created_at) VALUES(?, ?)',
      [note.text, note.dateTime.millisecondsSinceEpoch],
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await DBService.instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM notes ORDER BY created_at DESC'
    );

    return maps.map((json) => Note.fromMap(json)).toList();
  }
}
