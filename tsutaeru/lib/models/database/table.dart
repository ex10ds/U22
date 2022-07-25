enum SqlDataType { integer, text, blob }

class TableColumnInfo {
  final String columnName;
  final SqlDataType dataType;
  final bool isPrimaryKey;

  TableColumnInfo(this.columnName, this.dataType, this.isPrimaryKey);
}

class Table {
  final String tableName;
  final List<TableColumnInfo> columns;

  Table(this.tableName, this.columns);

  String getCreateTableSql() {
    String sql = "CREATE TABLE $tableName(";
    for (var c in columns) {
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
    for (var c in columns) {
      map.addAll({c.columnName: ""});
    }

    return map;
  }
}
