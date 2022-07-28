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
  Future create() async {
    var map = tableSchema.getColumnMap();
    map[columnId] = createUuid();
    map[columnTextColor] = textColor;
    map[columnBackgroundColor] = backgroundColor;
    id = map[columnId];
    await insert(map);
  }

  @override
  Future readById(String targetId) async {
    final pk = tableSchema.getPrimaryKeys()[0];
    var map = await getRecord({pk: targetId});
    id = map[columnId];
    textColor = map[columnTextColor];
    backgroundColor = map[columnBackgroundColor];
  }

  @override
  Future update() async {
    var map = tableSchema.getColumnMap();
    map[columnId] = id;
    map[columnTextColor] = textColor;
    map[columnBackgroundColor] = backgroundColor;
    await edit(map);
  }

  @override
  Future delete() async {
    final pk = tableSchema.getPrimaryKeys()[0];
    await destroy({pk: id});
  }
}
