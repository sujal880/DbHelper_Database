import 'dart:io';
import 'package:notes_database_wslc_147/notesmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DbHelper {
  static final DbHelper db = DbHelper();
  Database? _database;
  static const Note_table = "notes_table";
  static const Note_columnid = "note_id";
  static const Note_columntitle = "note_title";
  static const Note_desc = "note_desc";

  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path + "notesdb.db");
    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      db.execute(
          "create table $Note_table ( $Note_columnid integer primary key autoincrement, $Note_columntitle text, $Note_desc text ) ");
    });
  }

  Future<bool>addNotes(NotesModel notesModel)async{
    var db=await getDb();
    int rowseffect=await db.insert(Note_table, notesModel.toMap());
    return rowseffect>0;
  }

  Future<List<NotesModel>>fetchNotes()async{
    var db=await getDb();
    List<Map<String,dynamic>>notes=await db.query(Note_table);
    List<NotesModel>listNotes=[];
    for(Map<String,dynamic>notesModel in notes){
      NotesModel noteModel=NotesModel.fromMap(notesModel);
      listNotes.add(noteModel);
    }
    return listNotes;
  }
}
