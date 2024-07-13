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
      version: 1,
      onCreate: _onCreate,
    );
    return mydb;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "users" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "username" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      "login_status" BOOLEAN NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE "juices" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "price" INTEGER NOT NULL,
      "image" TEXT NOT NULL,
      "user_id" INTEGER NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users(id)
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

  Future<int?> insertUser(String username, String password) async {
    Database? mydb = await db;
    int? response = await mydb?.insert('users',
        {'username': username, 'password': password, 'login_status': 0});
    return response;
  }

  Future<Map<String, Object?>?> getUser(
      String username, String password) async {
    Database? mydb = await db;
    List<Map<String, Object?>>? response = await mydb?.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    return response?.isNotEmpty == true ? response?.first : null;
  }

  // Future<int?> updateLoginStatus(int userId, bool status) async {
  //   Database? mydb = await db;
  //   int? response = await mydb?.update(
  //       'users', {'login_status': status ? 1 : 0},
  //       where: 'id = ?', whereArgs: [userId]);
  //   return response;
  // }

  Future<void> initializeDatabase() async {
    await db;
  }
}
