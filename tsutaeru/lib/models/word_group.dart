import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/word_belonging.dart';

class WordGroup extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnName = "name";

  late String id;
  late String name;

  WordGroup()
      : super(SQLiteSchema("word_groups", [
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnId, SQLiteDataType.text),
        ])) {
    id = "";
    name = "";
  }

  @override
  Future<void> create() async {
    var map = tableSchema.getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnName] = name;
    insert(map);
  }

  @override
  Future<void> readById(String targetId) async {
    final pk = getPrimaryKeys()[0];
    var map = await getRecord({pk: targetId});
    id = map[_columnId];
    name = map[_columnName];
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnName] = name;
    edit(map);
  }

  @override
  Future<void> delete() async {
    WordBelonging().delete(wordGroupId: id);
    destroy({getPrimaryKeys()[0]: id});
  }
}
