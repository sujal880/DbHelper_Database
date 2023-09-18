import 'package:notes_database_wslc_147/dbhelper.dart';

class NotesModel {
  int? noteid;
  String title;
  String description;
  NotesModel({this.noteid, required this.title, required this.description});

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
        title: map[DbHelper.Note_columntitle],
        description: map[DbHelper.Note_desc],
        noteid: map[DbHelper.Note_columnid]);
  }

  Map<String,dynamic>toMap(){
    return {
      DbHelper.Note_columnid:noteid,
      DbHelper.Note_columntitle:title,
      DbHelper.Note_desc:description
    };
  }
}
