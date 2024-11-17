import 'package:flutter_hive/model/notes_model.dart';
import 'package:hive_flutter/adapters.dart';

class BoxPage{
  static Box<NotesModel> getData()=>Hive.box<NotesModel>('notes');
}