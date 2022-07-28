import 'package:flutter_test/flutter_test.dart';
import 'package:tsutaeru/models/database/sqlite_table.dart';

void main() {
  // correct declaration
  test("SQLiteTable Class getCreateTableSql test", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text, primaryKey: true),
      TableColumnInfo("name", SqlDataType.text),
      TableColumnInfo("date", SqlDataType.integer),
      TableColumnInfo("foreign_id", SqlDataType.integer,
          reference: "ref_table", referenceKey: "ref_key"),
    ]);
    String expected =
        "CREATE TABLE tableName(id TEXT NOT NULL, name TEXT NOT NULL, date INTEGER NOT NULL, foreign_id INTEGER NOT NULL, FOREIGN KEY (foreign_id) REFERENCES ref_table (ref_key), PRIMARY KEY (id))";
    expect(t.getCreateTableSql(), expected);

    // set primary key on multiple columns
    t = SQLiteTable("tableName", [
      TableColumnInfo("id1", SqlDataType.text, primaryKey: true),
      TableColumnInfo("id2", SqlDataType.text, primaryKey: true),
    ]);
    expected =
        "CREATE TABLE tableName(id1 TEXT NOT NULL, id2 TEXT NOT NULL, PRIMARY KEY (id1, id2))";
    expect(t.getCreateTableSql(), expected);
  });

  test("SQLiteTable Class getColumnMap test", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id1", SqlDataType.text, primaryKey: true),
      TableColumnInfo("id2", SqlDataType.text, primaryKey: true),
      TableColumnInfo("name", SqlDataType.text),
      TableColumnInfo("date", SqlDataType.integer),
    ]);
    Map<String, dynamic> expected = {
      "id1": "",
      "id2": "",
      "name": "",
      "date": 0
    };
    expect(t.getColumnMap(), expected);
    expect(t.getPrimaryKeys(), ["id1", "id2"]);
  });

  // SQLiteTable class cannot empty string in tableName, columnName
  test("SQLiteTable error handling about tableName", () {
    SQLiteTable t = SQLiteTable("", [
      TableColumnInfo("id", SqlDataType.text),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });

  test("SQLiteTable error handling about columnName", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("", SqlDataType.text),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });

  // primary key cannot be nullable
  test("SQLiteTableError primary key is nullable", () {
    SQLiteTable t = SQLiteTable("tableName", [
      TableColumnInfo("id", SqlDataType.text),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteTableError>()));
  });
}
