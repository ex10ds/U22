import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/models/phrase.dart';

class UnsafePhraseBelonging extends DatabaseHelper {
  static const _columnPhraseGroupId = "phrase_group_id";
  static const _columnPhraseId = "phrase_id";

  String getColPhraseGroupId() {
    return _columnPhraseGroupId;
  }

  String getColPhraseId() {
    return _columnPhraseId;
  }

  late String phraseGroupId;
  late String phraseId;

  UnsafePhraseBelonging()
      : super(SQLiteSchema("phrase_belonging", [
          SQLiteColumn(_columnPhraseGroupId, SQLiteDataType.text,
              primaryKey: true,
              reference: PhraseGroup().tableSchema.getTableName(),
              referenceKey: PhraseGroup().getPrimaryKeys()[0]),
          SQLiteColumn(_columnPhraseId, SQLiteDataType.text,
              primaryKey: true,
              reference: Phrase().tableSchema.getTableName(),
              referenceKey: Phrase().getPrimaryKeys()[0]),
        ])) {
    phraseGroupId = "";
    phraseId = "";
  }

  @override
  Future<void> create({String phraseGroupId = "", String phraseId = ""}) async {
    var map = getColumnMap();
    map[_columnPhraseGroupId] = phraseGroupId;
    map[_columnPhraseId] = phraseId;
    insert(map);
  }

  @override
  Future<List<Map<String, dynamic>>> readById(String targetId) async {
    var list = await getSomeRecord({_columnPhraseGroupId: targetId});
    return list;
  }

  @override
  Future<List<UnsafePhraseBelonging>> readAll() async {
    var list = await getAllRecord();
    List<UnsafePhraseBelonging> fb = [];
    for (var elem in list) {
      var tmp = UnsafePhraseBelonging();
      tmp.phraseGroupId = elem[_columnPhraseGroupId];
      tmp.phraseId = elem[_columnPhraseId];
      fb.add(tmp);
    }
    return fb;
  }

  @override
  Future<void> update({String phraseGroupId = "", String phraseId = ""}) async {
    var map = getColumnMap();
    map[_columnPhraseGroupId] = phraseGroupId;
    map[_columnPhraseId] = phraseId;
    edit(map);
  }

  @override
  Future<void> delete({String phraseGroupId = "", String phraseId = ""}) async {
    if (phraseGroupId != "" && phraseGroupId != "") {
      await destroy(
          {_columnPhraseGroupId: phraseGroupId, _columnPhraseId: phraseId});
    } else if (phraseGroupId != "") {
      await destroy({_columnPhraseGroupId: phraseGroupId});
    } else if (phraseId != "") {
      await destroy({_columnPhraseId: phraseId});
    }
  }
}

// wrapped class
class PhraseBelonging {
  final UnsafePhraseBelonging fb = UnsafePhraseBelonging();

  Future<void> create({String phraseGroupId = "", String phraseId = ""}) async {
    fb.create(phraseGroupId: phraseGroupId, phraseId: phraseId);
  }

  Future<List<Map<String, dynamic>>> readById(
      {String phraseGroupId = "", String phraseId = ""}) async {
    List<Map<String, dynamic>> list = [];
    if (phraseGroupId != "" && phraseId != "") {
      list = await fb.getSomeRecord({
        fb.getColPhraseGroupId(): phraseGroupId,
        fb.getColPhraseId(): phraseId
      });
    } else if (phraseGroupId != "") {
      list = await fb.getSomeRecord({fb.getColPhraseGroupId(): phraseGroupId});
    } else if (phraseId != "") {
      list = await fb.getSomeRecord({fb.getColPhraseId(): phraseId});
    }
    return list;
  }

  // remove from group
  Future<void> delete({String phraseGroupId = "", String phraseId = ""}) async {
    fb.delete(phraseGroupId: phraseGroupId, phraseId: phraseId);
  }
}
