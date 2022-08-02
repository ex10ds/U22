import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/word_belonging.dart';
import 'package:tsutaeru/models/word.dart';

class WordGroup extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnName = "name";

  late String id;
  late String name;
  late List<Word> words;

  WordGroup()
      : super(SQLiteSchema("word_groups", [
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnName, SQLiteDataType.text),
        ])) {
    id = "";
    name = "";
    words = [];
  }

  @override
  Future<void> create() async {
    var map = tableSchema.getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnName] = name;

    if (words.isNotEmpty) {
      for (var word in words) {
        WordBelonging()
            .create(wordGroupId: getPrimaryKeys()[0], wordId: word.id);
      }
    }

    insert(map);
  }

  @override
  Future<void> readById(String targetId) async {
    var map = await getRecord({getPrimaryKeys()[0]: targetId});
    id = map[_columnId];
    name = map[_columnName];
    var list = await WordBelonging().readById(wordGroupId: id);
    words = [];
    for (var elem in list) {
      Word word = Word();
      await word.readByMap(elem);
      words.add(word);
    }
  }

  @override
  Future<List<WordGroup>> readAll() async {
    var list = await getAllRecord();
    List<WordGroup> r = [];
    for (var map in list) {
      WordGroup object = WordGroup();
      object.id = map[_columnId];
      object.name = map[_columnName];

      var l = await WordBelonging().readById(wordGroupId: object.id);
      for (var elem in l) {
        Word word = Word();
        await word.readByMap(elem);
        object.words.add(word);
      }
      r.add(object);
    }
    return r;
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnName] = name;
    edit(map);

    if (words.isNotEmpty) {
      for (var word in words) {
        WordBelonging()
            .create(wordGroupId: getPrimaryKeys()[0], wordId: word.id);
      }
    }
  }

  @override
  Future<void> delete() async {
    WordBelonging().delete(wordGroupId: id);
    destroy({getPrimaryKeys()[0]: id});
  }
}
