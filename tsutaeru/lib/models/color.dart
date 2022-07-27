import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite_table.dart';

class Color extends DatabaseHelper {
  static const columnId = "id";
  static const columnTextColor = "text_color";
  static const columnBackgroundColor = "background_color";

  // table columns
  late String id;
  late int textColor;
  late int backgroundColor;

  // constructor
  Color()
      : super(SQLiteTable("colors", [
          // ... lumnInfo("COLUMN_NAME", DATA_TYPE)
          TableColumnInfo(columnId, SqlDataType.text, primaryKey: true),
          TableColumnInfo(columnTextColor, SqlDataType.integer),
          TableColumnInfo(columnBackgroundColor, SqlDataType.integer),
        ])) {
    id = "";
    textColor = 0;
    backgroundColor = 0;
  }

  @override
  void create() {
    var map = tableSchema.getColumnMap();
    map[columnId] = createUuid();
    map[columnTextColor] = textColor;
    map[columnBackgroundColor] = backgroundColor;
    insert(map);
  }

  @override
  void readById(String targetId) async {
    final pk = tableSchema.getPrimaryKeys()[0];
    var map = await getRecord({pk: id});
    id = map[columnId];
    textColor = map[columnTextColor];
    backgroundColor = map[columnBackgroundColor];
  }

  @override
  void update() {
    var map = tableSchema.getColumnMap();
    map[columnId] = id;
    map[columnTextColor] = textColor;
    map[columnBackgroundColor] = backgroundColor;
    edit(map);
  }

  @override
  void delete() {
    final pk = tableSchema.getPrimaryKeys()[0];
    destroy({pk: id});
  }
}
