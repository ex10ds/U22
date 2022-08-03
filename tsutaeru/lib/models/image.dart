import 'dart:typed_data';

import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/word.dart';

class Image extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnWordId = "word_id";
  static const _columnImage = "image";

  late String id;
  late String wordId;
  late Uint8List image;

  Image()
      : super(SQLiteSchema("images", [
          SQLiteColumn(_columnId, SQLiteDataType.text, primaryKey: true),
          SQLiteColumn(_columnWordId, SQLiteDataType.text,
              reference: Word().getTableName(),
              referenceKey: Word().getPrimaryKeys()[0]),
          SQLiteColumn(_columnImage, SQLiteDataType.blob),
        ])) {
    id = "";
    wordId = "";
    image = Uint8List(0);
  }

  @override
  Future<void> create() async {
    var map = getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnWordId] = wordId;
    map[_columnImage] = image;
    insert(map);
  }

  Future<List<Image>> readByWordId(String wordId) async {
    var list = await getSomeRecord({Word().getPrimaryKeys()[0]: wordId});
    List<Image> images = [];
    for (var map in list) {
      Image tmp = Image();
      tmp.id = map[_columnId];
      tmp.wordId = map[_columnWordId];
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
    wordId = map[_columnWordId];
    image = map[_columnImage];
  }

  @override
  Future<List<Image>> readAll() async {
    var list = await getAllRecord();
    List<Image> r = [];
    for (var map in list) {
      Image object = Image();
      object.id = map[_columnId];
      object.wordId = map[_columnWordId];
      object.image = map[_columnImage];
      r.add(object);
    }
    return r;
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnWordId] = wordId;
    map[_columnImage] = image;
    edit(map);
  }

  @override
  Future<void> delete() async {
    destroy({getPrimaryKeys()[0]: id});
  }
}
