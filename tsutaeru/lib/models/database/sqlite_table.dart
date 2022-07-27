enum SqlDataType { integer, text, blob }

class TableColumnInfo {
  final String columnName;
  final SqlDataType dataType;
  final bool isPrimaryKey;

  TableColumnInfo(this.columnName, this.dataType, this.isPrimaryKey);
}

class SQLiteTable {
  final String _tableName;
  final List<TableColumnInfo> _columns;

  SQLiteTable(this._tableName, this._columns);

  String getCreateTableSql() {
    String sql = "CREATE TABLE $_tableName(";
    for (var c in _columns) {
      String columnName = c.columnName;
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
      String pk = ", ";
      if (c.isPrimaryKey) {
        pk = " ";
        pk += "PRIMARY KEY";
        pk += ", ";
      }

      sql += "$columnName $type$pk";
    }
    sql = "${sql.substring(0, sql.length - 2)})";

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
