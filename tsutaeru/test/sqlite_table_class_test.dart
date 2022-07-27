import 'package:flutter_test/flutter_test.dart';
import 'package:tsutaeru/models/database/sqlite_table.dart';

void main() {
  // correct declaration
  test("SQLiteTable Class getCreateTableSql test", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text, true),
      TableColumnInfo("name", SqlDataType.text, false),
      TableColumnInfo("date", SqlDataType.integer, false),
    ]);

    String expected =
        "CREATE TABLE tableName(id TEXT PRIMARY KEY, name TEXT, date INTEGER)";

    expect(t.getCreateTableSql(), expected);
  });

  test("SQLiteTable Class getColumnMap test", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text, true),
      TableColumnInfo("name", SqlDataType.text, false),
      TableColumnInfo("date", SqlDataType.integer, false),
    ]);
    Map<String, String> expected = {"id": "", "name": "", "date": ""};
    expect(t.getColumnMap(), expected);
  });

  // SQLiteTable class cannot empty string in tableName, columnName
  test("SQLiteTable error handling about tableName", () {
    SQLiteTable t = SQLiteTable("", [
      TableColumnInfo("id", SqlDataType.text, true),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });

  test("SQLiteTable error handling about columnName", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("", SqlDataType.text, true),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });
}
