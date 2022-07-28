import 'dart:typed_data';

enum SqlDataType { integer, text, blob }

class TableColumnInfo {
  final String columnName;
  final SqlDataType dataType;
  final bool nullable;
  final bool primaryKey;
  final String reference;
  final String referenceKey;

  TableColumnInfo(
    this.columnName,
    this.dataType, {
    this.nullable = false,
    this.primaryKey = false,
    this.reference = "",
    this.referenceKey = "",
  });
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

  String getTableName() {
    return _tableName;
  }

  List<String> getPrimaryKeys() {
    List<String> list = [];
    for (var c in _columns) {
      if (c.primaryKey) {
        list.add(c.columnName);
      }
    }
    return list;
  }

  String getCreateTableSql() {
    if (_tableName == "") {
      throw SQLiteTableError("empty string cannot be specified in tableName");
    }

    String sql = "CREATE TABLE $_tableName(";

    List<String> primaryKeys = [];
    List<List<String>> foreignKeys = [];

    bool foundPK = false;

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
        foundPK = true;
        primaryKeys.add(c.columnName);
      }

      if (c.reference != "" && c.referenceKey != "") {
        foreignKeys.add([c.columnName, c.reference, c.referenceKey]);
      }

      sql += "$columnName $type$last";
    }

    if (!foundPK) {
      throw SQLiteTableError("one or more primary keys are required");
    }

    if (primaryKeys.isEmpty) {
      throw SQLiteTableError("table need primary key");
    }

    if (foreignKeys.isNotEmpty) {
      for (List<String> fk in foreignKeys) {
        sql += "FOREIGN KEY (${fk[0]}) REFERENCES ${fk[1]} (${fk[2]}), ";
      }
    }

    sql += "PRIMARY KEY (";

    for (var pk in primaryKeys) {
      sql += "$pk, ";
    }

    sql = "${sql.substring(0, sql.length - 2)}))";

    return sql;
  }

  Map<String, dynamic> getColumnMap() {
    Map<String, dynamic> map = {};
    for (var c in _columns) {
      switch (c.dataType) {
        case SqlDataType.integer:
          map.addAll({c.columnName: 0});
          break;
        case SqlDataType.text:
          map.addAll({c.columnName: ""});
          break;
        case SqlDataType.blob:
          Uint8List byte = Uint8List(0);
          map.addAll({c.columnName: byte});
          break;
      }
    }

    return map;
  }
}
