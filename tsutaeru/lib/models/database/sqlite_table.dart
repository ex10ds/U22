enum SqlDataType { integer, text, blob }

class TableColumnInfo {
  final String columnName;
  final SqlDataType dataType;
  final bool primaryKey;
  final bool nullable;

  TableColumnInfo(
      this.columnName, this.dataType, this.nullable, this.primaryKey);
}

class SQLiteTableError extends Error {
  final String message;
  SQLiteTableError(this.message);

  @override
  String toString() => message;
}

class SQLiteTable {
  final String _tableName;
  final List<TableColumnInfo> _columns;

  SQLiteTable(this._tableName, this._columns);

  String getCreateTableSql() {
    if (_tableName == "") {
      throw SQLiteTableError("empty string cannot be specified in tableName");
    }

    String sql = "CREATE TABLE $_tableName(";

    List<String> primaryKeys = [];

    for (var c in _columns) {
      String columnName = c.columnName;

      if (c.columnName == "") {
        throw SQLiteTableError(
            "empty string cannot be specified in columnName");
      }

      if (c.primaryKey && c.nullable) {
        throw SQLiteTableError("primary key cannot be nullable");
      }

      String type;
      switch (c.dataType) {
        case SqlDataType.integer:
          type = "INTEGER";
          break;
        case SqlDataType.text:
          type = "TEXT";
          break;
        case SqlDataType.blob:
          type = "BLOB";
          break;
      }

      String last = ", ";
      if (!c.nullable) {
        last = " NOT NULL, ";
      }

      if (c.primaryKey) {
        primaryKeys.add(c.columnName);
      }

      sql += "$columnName $type$last";
    }

    if (primaryKeys.isEmpty) {
      throw SQLiteTableError("table need primary key");
    }

    sql += "PRIMARY KEY (";

    for (var pk in primaryKeys) {
      sql += "$pk, ";
    }

    sql = "${sql.substring(0, sql.length - 2)}))";

    return sql;
  }

  Map<String, String> getColumnMap() {
    Map<String, String> map = {};
    for (var c in _columns) {
      map.addAll({c.columnName: ""});
    }

    return map;
  }
}