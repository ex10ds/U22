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
      : super(SQLiteSchema("color", [
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
    var map = await getRecord({getPrimaryKeys()[0]: targetId});
    id = map[_columnId];
    textColor = map[_columnTextColor];
    backgroundColor = map[_columnBackgroundColor];
  }

  @override
  Future<List<Color>> readAll() async {
    var list = await getAllRecord();
    List<Color> r = [];
    for (var map in list) {
      Color object = Color();
      object.id = map[_columnId];
      object.textColor = map[_columnTextColor];
      object.backgroundColor = map[_columnBackgroundColor];
      r.add(object);
    }
    return r;
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
