import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/values/internal.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelperError extends Error {
  final DatabaseHelperErrorType type;
  DatabaseHelperError(this.type);

  @override
  String toString() {
    switch (type) {
      case DatabaseHelperErrorType.mapIsNotCorrect:
        return "map received has Key that does not exist";
    }
  }
}

enum DatabaseHelperErrorType { mapIsNotCorrect }

abstract class DatabaseHelper {
  final SQLiteSchema tableSchema;
  DatabaseHelper(this.tableSchema);

  Future<void> create();
  Future<void> readById(String targetId);
  Future<void> update();
  Future<void> delete();

  Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (db, version) {
      return db.execute(tableSchema.getCreateTableSql());
    }, version: databaseVersion);
  }

  // CREATE
  @protected
  Future<void> insert(Map<String, dynamic> map) async {
    if (testAllMapKey(map)) {
      throw DatabaseHelperError(DatabaseHelperErrorType.mapIsNotCorrect);
    }
    final db = await _openDB();
    await db.insert(tableSchema.getTableName(), map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // READ
  @protected
  Future<Map<String, dynamic>> getRecord(Map<String, dynamic> whereAnd) async {
    if (testSomeMapKey(whereAnd)) {
      throw DatabaseHelperError(DatabaseHelperErrorType.mapIsNotCorrect);
    }
    final db = await _openDB();
    Map<String, dynamic> map = tableSchema.getColumnMap();

    String where = "";
    List<dynamic> whereArgs = [];

    whereAnd.forEach((key, value) {
      if (value != null) {
        where += "$key = ? and ";
        whereArgs.add(value);
      }
    });
    where = where.substring(0, where.length - 5);

    var maps = await db.query(tableSchema.getTableName(),
        where: where, whereArgs: whereArgs, limit: 1);

    map.forEach((key, value) {
      if (maps.isNotEmpty) {
        map[key] = maps[0][key];
      }
    });

    return map;
  }

  Future<List<Map<String, dynamic>>> getSomeRecord(
      Map<String, dynamic> whereAnd) async {
    if (testSomeMapKey(whereAnd)) {
      throw DatabaseHelperError(DatabaseHelperErrorType.mapIsNotCorrect);
    }
    final db = await _openDB();

    String where = "";
    List<dynamic> whereArgs = [];

    whereAnd.forEach((key, value) {
      if (value != null) {
        where += "$key = ? and ";
        whereArgs.add(value);
      }
    });
    where = where.substring(0, where.length - 5);

    var maps = await db.query(tableSchema.getTableName(),
        where: where, whereArgs: whereArgs);

    return maps;
  }

  // UPDATE
  @protected
  Future<void> edit(Map<String, dynamic> map) async {
    if (testAllMapKey(map)) {
      throw DatabaseHelperError(DatabaseHelperErrorType.mapIsNotCorrect);
    }
    final db = await _openDB();
    await db.update(tableSchema.getTableName(), map);
  }

  // DELETE
  @protected
  Future<void> destroy(Map<String, dynamic> whereAnd) async {
    if (testSomeMapKey(whereAnd)) {
      throw DatabaseHelperError(DatabaseHelperErrorType.mapIsNotCorrect);
    }
    final db = await _openDB();

    String where = "";
    List<dynamic> whereArgs = [];

    whereAnd.forEach((key, value) {
      if (value != null) {
        where += "$key = ? and ";
        whereArgs.add(value);
      }
    });
    where = where.substring(0, where.length - 5);

    await db.delete(tableSchema.getTableName(),
        where: where, whereArgs: whereArgs);
  }

  // wrapper functions
  String getTableName() {
    return tableSchema.getTableName();
  }

  Map<String, dynamic> getColumnMap() {
    return tableSchema.getColumnMap();
  }

  List<String> getPrimaryKeys() {
    return tableSchema.getPrimaryKeys();
  }

  // methods for sub class
  @protected
  String createUuid() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }

  @protected
  bool testAllMapKey(Map<String, dynamic> map) {
    Map<String, dynamic> fromSchema = tableSchema.getColumnMap();
    bool flag = true;

    fromSchema.forEach((k, _) {
      if (!map.containsKey(k)) {
        flag = false;
      }
    });

    map.forEach((k, _) {
      if (!fromSchema.containsKey(k)) {
        flag = false;
      }
    });

    return flag;
  }

  @protected
  bool testSomeMapKey(Map<String, dynamic> map) {
    Map<String, dynamic> fromSchema = tableSchema.getColumnMap();
    bool flag = true;

    map.forEach((k, _) {
      if (!fromSchema.containsKey(k)) {
        flag = false;
      }
    });

    return flag;
  }
}
