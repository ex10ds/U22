import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/word_belonging.dart';

class Word extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnText = "text";
  static const _columnColorId = "color_id";

  late String id;
  late String text;
  late Color color;

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
  }

  Future<void> readByMap(Map<String, dynamic> map) async {
    if (!testAllMapKey(map)) {
      callTestAnyMapError();
    }

    id = map[_columnId];
    text = map[_columnText];
    color = Color();
    await color.readById(map[_columnColorId]);
  }

  @override
  Future<void> create() async {
    var map = getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnText] = text;
    map[_columnColorId] = color.id;
    insert(map);
  }

  @override
  Future<void> readById(String targetId) async {
    var map = await getRecord({getPrimaryKeys()[0]: targetId});
    id = map[_columnId];
    text = map[_columnText];
    await color.readById(map[_columnColorId]);
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnText] = text;
    map[_columnColorId] = color.id;
    edit(map);
  }

  @override
  Future<void> delete() async {
    WordBelonging().delete(wordId: id);
    destroy({_columnId: id});
  }
}
