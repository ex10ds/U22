import 'package:flutter_test/flutter_test.dart';
import 'package:tsutaeru/models/database/sqlite_table.dart';

void main() {
  // correct declaration
  test("SQLiteTable Class getCreateTableSql test", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text, false, true),
      TableColumnInfo("name", SqlDataType.text, false, false),
      TableColumnInfo("date", SqlDataType.integer, false, false),
    ]);
    String expected =
        "CREATE TABLE tableName(id TEXT NOT NULL, name TEXT NOT NULL, date INTEGER NOT NULL, PRIMARY KEY (id))";
    expect(t.getCreateTableSql(), expected);

    // set primary key on multiple columns
    t = SQLiteTable("tableName", [
      TableColumnInfo("id1", SqlDataType.text, false, true),
      TableColumnInfo("id2", SqlDataType.text, false, true),
    ]);
    expected =
        "CREATE TABLE tableName(id1 TEXT NOT NULL, id2 TEXT NOT NULL, PRIMARY KEY (id1, id2))";
    expect(t.getCreateTableSql(), expected);
  });

  test("SQLiteTable Class getColumnMap test", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text, false, true),
      TableColumnInfo("name", SqlDataType.text, false, false),
      TableColumnInfo("date", SqlDataType.integer, false, false),
    ]);
    Map<String, String> expected = {"id": "", "name": "", "date": ""};
    expect(t.getColumnMap(), expected);
  });

  // SQLiteTable class cannot empty string in tableName, columnName
  test("SQLiteTable error handling about tableName", () {
    SQLiteTable t = SQLiteTable("", [
      TableColumnInfo("id", SqlDataType.text, false, true),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });

  test("SQLiteTable error handling about columnName", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("", SqlDataType.text, false, true),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });

  // primary key cannot be nullable
  test("SQLiteTableError primary key is nullable", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text, true, true),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });
}
