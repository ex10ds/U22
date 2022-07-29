import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/word_group.dart';
import 'package:tsutaeru/models/words.dart';

// wrapper class
class UnsafeWordBelonging extends DatabaseHelper {
  static const _columnWordGroupId = "word_group_id";
  static const _columnWordId = "word_id";

  String getColWordGroupId() {
    return _columnWordGroupId;
  }

  String getColWordId() {
    return _columnWordId;
  }

  late WordGroup wordGroup;
  late Word word;

  UnsafeWordBelonging()
      : super(SQLiteSchema("words_belonging", [
          SQLiteColumn(_columnWordGroupId, SQLiteDataType.text,
              primaryKey: true,
              reference: WordGroup().tableSchema.getTableName(),
              referenceKey: WordGroup().getPrimaryKeys()[0]),
          SQLiteColumn(_columnWordId, SQLiteDataType.text,
              primaryKey: true,
              reference: Word().tableSchema.getTableName(),
              referenceKey: Word().getPrimaryKeys()[0]),
        ])) {
    wordGroup = WordGroup();
    word = Word();
  }

  @override
  Future<void> create() async {}

  @override
  Future<void> readById(String targetId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> update() async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete({String wordGroupId = "", String wordId = ""}) async {
    if (wordGroupId != "") {
      await destroy({_columnWordGroupId: wordGroupId});
    }
    if (wordId != "") {
      await destroy({_columnWordId: wordId});
    }
  }
}

class WordBelonging {
  final UnsafeWordBelonging wb = UnsafeWordBelonging();

  Future<List<Map<String, dynamic>>> readById(
      {wordGroupId = "", wordId = ""}) async {
    List<Map<String, dynamic>> list = [];
    if (wordGroupId != "" && wordId != "") {
      list = await wb.getSomeRecord(
          {wb.getColWordGroupId(): wordGroupId, wb.getColWordId(): wordId});
    } else if (wordGroupId != "") {
      list = await wb.getSomeRecord({wb.getColWordGroupId(): wordGroupId});
    } else if (wordId != "") {
      list = await wb.getSomeRecord({wb.getColWordId(): wordId});
    }
    return list;
  }

  Future<void> delete({wordGroupId = "", wordId = ""}) async {
    wb.delete(wordGroupId: wordGroupId, wordId: wordId);
  }
}
