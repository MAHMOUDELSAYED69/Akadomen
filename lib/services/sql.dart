import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'akadomen.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
    );
    return mydb;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "juices" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "Image" TEXT NOT NULL
  )
 ''');
    debugPrint("DB Created!");
  }

  Future<List<Map<String, Object?>>?> readData({required String data}) async {
    Database? mydb = await db;
    List<Map<String, Object?>>? response = await mydb?.rawQuery(data);
    return response;
  }

  Future<int?> insertData({required String data}) async {
    Database? mydb = await db;
    int? response = await mydb?.rawInsert(data);
    return response;
  }

  Future<int?> updateData({required String data}) async {
    Database? mydb = await db;
    int? response = await mydb?.rawUpdate(data);
    return response;
  }

  Future<int?> deleteData({required String data}) async {
    Database? mydb = await db;
    int? response = await mydb?.rawDelete(data);
    return response;
  }
}
