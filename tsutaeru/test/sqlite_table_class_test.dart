import 'package:flutter_test/flutter_test.dart';
import 'package:tsutaeru/models/database/sqlite.dart';

void main() {
  // correct declaration
  test("SQLiteSchema Class getCreateTableSql test", () {
    SQLiteSchema t = SQLiteSchema("tableName", [
      SQLiteColumn("id", SQLiteDataType.text, primaryKey: true),
      SQLiteColumn("name", SQLiteDataType.text),
      SQLiteColumn("date", SQLiteDataType.integer),
      SQLiteColumn("foreign_id", SQLiteDataType.integer,
          reference: "ref_table", referenceKey: "ref_key"),
    ]);
    String expected =
        "CREATE TABLE tableName(id TEXT NOT NULL, name TEXT NOT NULL, date INTEGER NOT NULL, foreign_id INTEGER NOT NULL, FOREIGN KEY (foreign_id) REFERENCES ref_table (ref_key), PRIMARY KEY (id));";
    expect(t.getCreateTableSql(), expected);

    // set primary key on multiple columns
    t = SQLiteSchema("tableName", [
      SQLiteColumn("id1", SQLiteDataType.text, primaryKey: true),
      SQLiteColumn("id2", SQLiteDataType.text, primaryKey: true),
    ]);
    expected =
        "CREATE TABLE tableName(id1 TEXT NOT NULL, id2 TEXT NOT NULL, PRIMARY KEY (id1, id2));";
    expect(t.getCreateTableSql(), expected);
  });

  test("SQLiteSchema Class getColumnMap test", () {
    SQLiteSchema t = SQLiteSchema("tableName", [
      SQLiteColumn("id1", SQLiteDataType.text, primaryKey: true),
      SQLiteColumn("id2", SQLiteDataType.text, primaryKey: true),
      SQLiteColumn("name", SQLiteDataType.text),
      SQLiteColumn("date", SQLiteDataType.integer),
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

  // SQLiteSchema class cannot empty in tableName, columnName
  test("SQLiteSchema error handling about tableName", () {
    SQLiteSchema t = SQLiteSchema("", [
      SQLiteColumn("id", SQLiteDataType.text),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteSchemaError>()));
  });

  test("SQLiteSchema error handling about columnName", () {
    SQLiteSchema t = SQLiteSchema("tableName", [
      SQLiteColumn("", SQLiteDataType.text),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteSchemaError>()));
  });

  // primary key cannot be nullable
  test("SQLiteSchemaError primary key is nullable", () {
    SQLiteSchema t = SQLiteSchema("tableName", [
      SQLiteColumn("id", SQLiteDataType.text),
    ]);

    expect(() => t.getCreateTableSql(),
        throwsA(const TypeMatcher<SQLiteSchemaError>()));
  });
}
