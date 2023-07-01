import 'dart:async';
import 'dart:io' as io;
import 'package:movie_search/constants/db_constants.dart';
import 'package:movie_search/data/movies/models/movie_favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static Database? _db;

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DbConstants.dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE ${DbConstants.tableMovieFavorite} (${DbConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, ${MovieFavorite.kImdbId} TEXT, ${MovieFavorite.kName} TEXT, ${MovieFavorite.kYear} TEXT, ${MovieFavorite.kRuntime} TEXT)");
  }

  Future<void> insert(
      {required String table, required Map<String, dynamic> row}) async {
    var db = await database;
    await db?.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> selectAll({required String table}) async {
    var db = await database;
    final List<Map<String, dynamic>> maps =
        await db?.query(table) ?? List.empty();
    return maps;
  }

  Future<void> delete(
      {required String table,
      required String whereColumn,
      required dynamic whereValue}) async {
    var db = await database;
    await db?.delete(
      table,
      where: '$whereColumn = ?',
      whereArgs: [whereValue],
    );
  }

  Future<void> update(
      {required String table,
      required String whereColumn,
      required dynamic whereValue,
      required Map<String, dynamic> row}) async {
    var db = await database;
    await db?.update(
      table,
      row,
      where: '$whereColumn = ?',
      whereArgs: [whereValue],
    );
  }

  Future<void> closeDb() async {
    var db = await database;
    await db?.close();
  }
}
