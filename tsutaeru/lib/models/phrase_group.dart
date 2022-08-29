import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/phrase_belonging.dart';
import 'package:tsutaeru/models/phrase.dart';

class PhraseGroup extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnName = "name";

  late String id;
  late String name;
  late List<Phrase> phrases;

  PhraseGroup()
      : super(SQLiteSchema("phrase_groups", [
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnName, SQLiteDataType.text),
        ])) {
    id = "";
    name = "";
    phrases = [];
  }

  @override
  Future<void> create() async {
    var map = tableSchema.getColumnMap();
    id = createUuid();
    map[_columnId] = id;

    if (name == "") {
      throw DatabaseHelperException(
          DatabaseHelperExceptionType.failedToInsertRecord);
    }

    map[_columnName] = name;

    if (phrases.isNotEmpty) {
      for (var phrase in phrases) {
        PhraseBelonging()
            .create(phraseGroupId: getPrimaryKeys()[0], phraseId: phrase.id);
      }
    }

    insert(map);
  }

  @override
  Future<void> readById(String targetId) async {
    var map = await getRecord({getPrimaryKeys()[0]: targetId});
    id = map[_columnId];
    name = map[_columnName];
    var list = await PhraseBelonging().readById(phraseGroupId: id);
    phrases = [];
    for (var elem in list) {
      var phraseId = elem[UnsafePhraseBelonging().getColPhraseId()];
      Phrase phrase = Phrase();
      await phrase.readById(phraseId);
      phrases.add(phrase);
    }
  }

  @override
  Future<List<PhraseGroup>> readAll() async {
    var list = await getAllRecord();
    List<PhraseGroup> r = [];
    for (var map in list) {
      PhraseGroup object = PhraseGroup();
      object.id = map[_columnId];
      object.name = map[_columnName];

      // phrase_group_id, phrase_id into "l"
      var l = await PhraseBelonging().readById(phraseGroupId: object.id);
      for (var elem in l) {
        Phrase phrase = Phrase();
        await phrase.readById(elem[UnsafePhraseBelonging().getColPhraseId()]);
        object.phrases.add(phrase);
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

    if (phrases.isNotEmpty) {
      for (var phrase in phrases) {
        PhraseBelonging()
            .create(phraseGroupId: getPrimaryKeys()[0], phraseId: phrase.id);
      }
    }
  }

  @override
  Future<void> delete() async {
    PhraseBelonging().delete(phraseGroupId: id);
    destroy({getPrimaryKeys()[0]: id});
  }
}
