import 'dart:typed_data';

import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/phrase.dart';

class Image extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnPhraseId = "phrase_id";
  static const _columnImage = "image";

  late String id;
  late String phraseId;
  late Uint8List image;

  Image()
      : super(SQLiteSchema("image", [
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnPhraseId, SQLiteDataType.text,
              reference: Phrase().getTableName(),
              referenceKey: Phrase().getPrimaryKeys()[0]),
          SQLiteColumn(_columnImage, SQLiteDataType.blob),
        ])) {
    id = "";
    phraseId = "";
    image = Uint8List(0);
  }

  @override
  Future<void> create() async {
    var map = getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnPhraseId] = phraseId;
    map[_columnImage] = image;
    insert(map);
  }

  Future<List<Image>> readByPhraseId(String phraseId) async {
    var list = await getSomeRecord({Phrase().getPrimaryKeys()[0]: phraseId});
    List<Image> images = [];
    for (var map in list) {
      Image tmp = Image();
      tmp.id = map[_columnId];
      tmp.phraseId = map[_columnPhraseId];
      tmp.image = map[_columnImage];
      images.add(tmp);
    }
    return images;
  }

  @override
  Future<void> readById(String targetId) async {
    final pk = getPrimaryKeys()[0];
    var map = await getRecord({pk: targetId});
    id = map[_columnId];
    phraseId = map[_columnPhraseId];
    image = map[_columnImage];
  }

  @override
  Future<List<Image>> readAll() async {
    var list = await getAllRecord();
    List<Image> r = [];
    for (var map in list) {
      Image object = Image();
      object.id = map[_columnId];
      object.phraseId = map[_columnPhraseId];
      object.image = map[_columnImage];
      r.add(object);
    }
    return r;
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnPhraseId] = phraseId;
    map[_columnImage] = image;
    edit(map);
  }

  @override
  Future<void> delete() async {
    destroy({getPrimaryKeys()[0]: id});
  }
}
