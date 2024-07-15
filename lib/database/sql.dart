
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static final SqlDb _instance = SqlDb._internal();
  static Database? _db;

  factory SqlDb() {
    return _instance;
  }

  SqlDb._internal();

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'akadomen.db');
    Database mydb = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
    return mydb;
  }

  Future<void> deleteAndRecreateDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'akadomen.db');
    await deleteDatabase(path);
  }

  Future<void> _onCreate(Database db, int version) async {
    //? Create 'users' table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        login_status BOOLEAN NOT NULL,
        invoice_number INTEGER DEFAULT 0
      )
    ''');

    //? Create 'juices' table
    await db.execute('''
      CREATE TABLE juices (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price INTEGER NOT NULL,
        image TEXT NOT NULL,
        username TEXT NOT NULL,
        FOREIGN KEY (username) REFERENCES users(username)
      )
    ''');

    //? Create 'invoices' table
    await db.execute('''
  CREATE TABLE IF NOT EXISTS invoices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    invoice_number INTEGER NOT NULL,
    customer_name TEXT NOT NULL,
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    total_amount REAL NOT NULL,
    items TEXT,  -- Add items column here
    username TEXT NOT NULL,
    FOREIGN KEY (username) REFERENCES users(username)
  )
''');

    debugPrint("DB Created!");
  }

  // Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 3) {
  //     await db.execute(
  //         'ALTER TABLE users ADD COLUMN invoice_number INTEGER DEFAULT 0');
  //     debugPrint("DB Upgraded to version 3!");
  //   }
  //   if (oldVersion < 4) {
  //     await db.execute('''
  //       CREATE TABLE IF NOT EXISTS new_table (
  //         id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  //         name TEXT NOT NULL
  //       )
  //     ''');
  //     debugPrint("DB Upgraded to version 4!");
  //   }
  // Add upgrade logic for other versions
  // Example:
  // if (oldVersion < 5) {
  //   await db.execute('ALTER TABLE existing_table ADD COLUMN new_column TEXT');
  //   debugPrint("DB Upgraded to version 5!");
  // }
  // }

  Future<void> saveInvoice(Map<String, dynamic> invoiceData) async {
    Database? mydb = await db;
    await mydb?.insert('invoices', invoiceData);
  }

  Future<List<Map<String, dynamic>>?> readData({required String data}) async {
    Database? mydb = await db;
    List<Map<String, dynamic>>? response = await mydb?.rawQuery(data);
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
    int? response = await mydb?.insert('users', {
      'username': username,
      'password': password,
      'login_status': 0,
      'invoice_number': 0
    });
    return response;
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    Database? mydb = await db;
    List<Map<String, dynamic>>? response = await mydb?.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    return response?.isNotEmpty == true ? response?.first : null;
  }

  Future<int?> getNextInvoiceNumber(String username) async {
    Database? mydb = await db;
    List<Map<String, dynamic>>? result = await mydb?.query('users',
        columns: ['invoice_number'],
        where: 'username = ?',
        whereArgs: [username]);

    if (result != null && result.isNotEmpty) {
      int invoiceNumber = result.first['invoice_number'] as int;
      invoiceNumber++;
      int? updateResponse = await mydb?.update(
          'users', {'invoice_number': invoiceNumber},
          where: 'username = ?', whereArgs: [username]);

      if (updateResponse != null && updateResponse > 0) {
        return invoiceNumber;
      } else {
        debugPrint('Failed to update invoice number for user $username');
        return null;
      }
    } else {
      debugPrint('No user found with username $username');
      return null;
    }
  }

  Future<void> initializeDatabase() async {
    await db;
  }
}