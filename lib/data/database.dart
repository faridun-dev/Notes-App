import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List notes = [];

  final _boxData = Hive.box("notes");

  void createInitialData() {
    notes = [
      ["Default task", "Content is simple"],
    ];
  }

  void loadData() {
    notes = _boxData.get("NOTES");
  }

  void updateDataBase() {
    _boxData.put("NOTES", notes);
  }
}
