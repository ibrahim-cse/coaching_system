import 'dart:io' as io;

import 'package:coaching_system/model/lecture_video_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LectureVideoDbHelper {
  static Database? _db;

  static const String dbName = 'videos.db';
  static const String tableUser = 'teacher';
  static const int version = 1;

  static const String cContentPath = 'contentPath';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        " $cContentPath TEXT, "
        "PRIMARY KEY ($cContentPath)"
        ")");
  }

  Future<int> saveData(LectureVideoModel lectureVideo) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, lectureVideo.toMap());
    return res;
  }

  Future<LectureVideoModel?> getLoginUser(
      String contentPath, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableUser WHERE "
        "$cContentPath = '$contentPath'");

    if (res.length > 0) {
      return LectureVideoModel.fromMap(res.first);
    }
    return null;
  }
}
