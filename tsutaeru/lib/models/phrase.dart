import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/phrase_belonging.dart';

class Phrase extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnText = "text";
  static const _columnColorId = "color_id";

  late String id;
  late String text;
  late Color color;

  Phrase()
      : super(SQLiteSchema("phrase", [
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

  @override
  Future<void> create() async {
    var map = getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnText] = text;
    map[_columnColorId] = color.id;
    insert(map);
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
  Future<void> readById(String targetId) async {
    var map = await getRecord({getPrimaryKeys()[0]: targetId});
    id = map[_columnId];
    text = map[_columnText];
    await color.readById(map[_columnColorId]);
  }

  @override
  Future<List<Phrase>> readAll() async {
    var list = await getAllRecord();
    List<Phrase> r = [];
    for (var map in list) {
      Phrase object = Phrase();
      object.id = map[_columnId];
      object.text = map[_columnText];
      var tmp = Color();
      await tmp.readById(map[_columnColorId]);
      object.color = tmp;
      r.add(object);
    }
    return r;
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
    PhraseBelonging().delete(phraseId: id);
    destroy({_columnId: id});
  }
}
