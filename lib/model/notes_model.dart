import 'package:hive_flutter/adapters.dart';
part 'notes_model.g.dart';

//flutter packages pub run build_runner build
// notes_model.g banana ke lie command main flutter packages pub run build_runner build challah pare ga
@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
   String title;
  @HiveField(1)
   String directory;

  NotesModel({required this.title, required this.directory,});

  // deletes() {}



}