import 'dart:typed_data';

enum SQLiteDataType { integer, text, blob }

class SQLiteColumn {
  final String columnName;
  final SQLiteDataType dataType;
  final bool nullable;
  final bool primaryKey;
  final String reference;
  final String referenceKey;

  SQLiteColumn(
    this.columnName,
    this.dataType, {
    this.nullable = false,
    this.primaryKey = false,
    this.reference = "",
    this.referenceKey = "",
  });
}

class SQLiteSchemaError extends Error {
  final SQLSchemaErrorType type;
  SQLiteSchemaError(this.type);

  @override
  String toString() {
    switch (type) {
      case SQLSchemaErrorType.emptyTableName:
        return "empty string cannot be specified in tableName";
      case SQLSchemaErrorType.emptyColumnName:
        return "empty string cannot be specified in columnName";
      case SQLSchemaErrorType.nullablePrimaryKey:
        return "primary key cannot be nullable";
      case SQLSchemaErrorType.nonPrimaryKey:
        return "table needs primary key";
    }
  }
}

enum SQLSchemaErrorType {
  emptyTableName,
  emptyColumnName,
  nullablePrimaryKey,
  nonPrimaryKey,
}

class SQLiteSchema {
  final String _tableName;
  final List<SQLiteColumn> _columns;

  SQLiteSchema(this._tableName, this._columns);

  String getCreateTableSql() {
    if (_tableName == "") {
      throw SQLiteSchemaError(SQLSchemaErrorType.emptyTableName);
    }

    String sql = "CREATE TABLE $_tableName(";

    List<String> primaryKeys = [];
    List<List<String>> foreignKeys = [];

    for (var c in _columns) {
      String columnName = c.columnName;

      if (c.columnName == "") {
        throw SQLiteSchemaError(SQLSchemaErrorType.emptyColumnName);
      }

      if (c.primaryKey && c.nullable) {
        throw SQLiteSchemaError(SQLSchemaErrorType.nullablePrimaryKey);
      }

      String type;
      switch (c.dataType) {
        case SQLiteDataType.integer:
          type = "INTEGER";
          break;
        case SQLiteDataType.text:
          type = "TEXT";
          break;
        case SQLiteDataType.blob:
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

      if (c.reference != "" && c.referenceKey != "") {
        foreignKeys.add([c.columnName, c.reference, c.referenceKey]);
      }

      sql += "$columnName $type$last";
    }

    if (primaryKeys.isEmpty) {
      throw SQLiteSchemaError(SQLSchemaErrorType.nonPrimaryKey);
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

  // they will be wrapped
  String getTableName() {
    return _tableName;
  }

  Map<String, dynamic> getColumnMap() {
    Map<String, dynamic> map = {};
    for (var c in _columns) {
      switch (c.dataType) {
        case SQLiteDataType.integer:
          map.addAll({c.columnName: 0});
          break;
        case SQLiteDataType.text:
          map.addAll({c.columnName: ""});
          break;
        case SQLiteDataType.blob:
          Uint8List byte = Uint8List(0);
          map.addAll({c.columnName: byte});
          break;
      }
    }
    return map;
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
}
