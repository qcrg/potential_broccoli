import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:potential_broccoli/errors.dart';
import 'package:potential_broccoli/models/database/users.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static DB? _instance;

  final Database _db;

  DB._(this._db);

  static Future<DB> create({String name = "database"}) async {
    if (_instance != null) {
      return Future.value(_instance);
    }

    String prefix = "";
    if (!kIsWeb) {
      prefix = (await getApplicationSupportDirectory()).path;
    }
    String path = join(prefix, "$name.db");
    Database db = await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        return await db.execute("""
          CREATE TABLE ${UserFields.table_name_} (
            ${UserFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${UserFields.full_name} VARCHAR(63) NOT NULL UNIQUE,
            ${UserFields.nickname} VARCHAR(31),
            ${UserFields.birthday} DATE
          );
        """);
      },
      version: 1,
    );
    _instance = DB._(db);
    return Future.value(_instance);
  }

  Future<User?> get_user(int id) async {
    var ans = await _db.query(
      UserFields.table_name_,
      columns: [UserFields.full_name, UserFields.nickname, UserFields.birthday],
      limit: 1,
      where: "id = ?",
      whereArgs: [id],
    );
    if (ans.isEmpty) return null;
    var res = ans.first;
    return User(
      id: id,
      full_name: res[UserFields.full_name] as String,
      nickname: res[UserFields.nickname] as String?,
      birthday: res[UserFields.birthday] as DateTime,
    );
  }

  FutErr insert_user(User user) async {
    if (0 == await _db.insert(UserFields.table_name_, user.toMap())) {
      return Err("Failed to add new user");
    }
    return null;
  }

  FutErr delete_user(User user) async {
    final count = await _db.delete(
      UserFields.table_name_,
      where: "full_name = ?",
      whereArgs: [user.full_name],
    );
    if (count == 0) {
      return Err("Failed to remove user");
    }
    return null;
  }

  Future<List<User>> get_users({int? offset, int? limit}) async {
    var ans = await _db.query(
      UserFields.table_name_,
      offset: offset,
      limit: limit,
    );
    return List<User>.generate(ans.length, (int idx) => User.fromMap(ans[idx]));
  }
}
