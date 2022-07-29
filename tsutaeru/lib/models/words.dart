import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/word_group.dart';

class Word extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnText = "text";
  static const _columnColorId = "color_id";

  late String id;
  late String text;
  late Color color;
  late List<WordGroup> group;

  Word()
      : super(SQLiteSchema("words", [
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnColorId, SQLiteDataType.text,
              reference: Color().getTableName(),
              referenceKey: Color().getPrimaryKeys()[0]),
          SQLiteColumn(_columnText, SQLiteDataType.text),
        ])) {
    id = "";
    text = "";
    color = Color();
    group = [];
  }

  @override
  Future<void> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> readById(String targetId) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
