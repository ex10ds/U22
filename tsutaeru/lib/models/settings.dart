import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/values/colors.dart';

class Settings extends DatabaseHelper {
  final String id = "current";
  late int fontSize;
  late int primaryColor;

  Settings()
      : super(SQLiteSchema("settings", [
          SQLiteColumn("id", SQLiteDataType.text, primaryKey: true),
          SQLiteColumn("font_size", SQLiteDataType.integer),
          SQLiteColumn("primary_color", SQLiteDataType.integer),
        ])) {
    fontSize = 0;
    primaryColor = 0;
  }
  @override
  Future<void> create() async {
    var map = getColumnMap();
    map["id"] = id;

    map["font_size"] = fontSize;
    map["primary_color"] = primaryColor;
    await insert(map);
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Object>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> readById(String targetId) async {
    var map = await getRecord({getPrimaryKeys()[0]: id});
    fontSize = map["font_size"];
    primaryColor = map["primary_color"];
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map["id"] = id;

    map["font_size"] = fontSize;
    map["primary_color"] = primaryColor;
    await edit(map);
  }

  Future<void> check() async {
    await readById(id);
    if (fontSize == 0 || primaryColor == 0) {
      primaryColor = AppColor.primaryColor;
      fontSize = 30;
      update();
    }
  }
}
