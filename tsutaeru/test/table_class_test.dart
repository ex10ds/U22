import 'package:flutter_test/flutter_test.dart';
import 'package:tsutaeru/models/database/table.dart';

void main() {
  Table t = Table("tableName", [
    TableColumnInfo("id", SqlDataType.text, true),
    TableColumnInfo("name", SqlDataType.text, false),
    TableColumnInfo("date", SqlDataType.integer, false),
  ]);

  String expected =
      "CREATE TABLE tableName(id TEXT PRIMARY KEY, name TEXT, date INTEGER)";

  test("Table Class test", () {
    expect(t.getCreateTableSql(), expected);
  });
}
