import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';

class Color extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnTextColor = "text_color";
  static const _columnBackgroundColor = "background_color";

  // table columns
  late String id;
  late int textColor;
  late int backgroundColor;

  // constructor
  Color()
      : super(SQLiteSchema("colors", [
          // ... lumnInfo("COLUMN_NAME", DATA_TYPE)
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnTextColor, SQLiteDataType.integer),
          SQLiteColumn(_columnBackgroundColor, SQLiteDataType.integer),
        ])) {
    id = "";
    textColor = 0;
    backgroundColor = 0;
  }

  @override
  Future<void> create() async {
    var map = getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnTextColor] = textColor;
    map[_columnBackgroundColor] = backgroundColor;
    insert(map);
  }

  @override
  Future<void> readById(String targetId) async {
    final pk = getPrimaryKeys()[0];
    var map = await getRecord({pk: targetId});
    id = map[_columnId];
    textColor = map[_columnTextColor];
    backgroundColor = map[_columnBackgroundColor];
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnTextColor] = textColor;
    map[_columnBackgroundColor] = backgroundColor;
    edit(map);
  }

  @override
  Future<void> delete() async {
    destroy({getPrimaryKeys()[0]: id});
  }
}
