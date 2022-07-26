import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tsutaeru/values/strings.dart';

class DatabaseHelper {
  late final database;

  DatabaseHelper(String createTableSql) {
    () async {
      database = openDatabase(join(await getDatabasesPath(), databaseName));
    };
  }
}
