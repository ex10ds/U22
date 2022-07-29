import 'dart:typed_data';

import 'package:tsutaeru/models/database/database_helper.dart';
import 'package:tsutaeru/models/database/sqlite.dart';
import 'package:tsutaeru/models/words.dart';

class Image extends DatabaseHelper {
  static const _columnId = "id";
  static const _columnWordId = "word_id";
  static const _columnImage = "image";

  late String id;
  late Word word;
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
    word = Word();
    image = Uint8List(0);
  }

  @override
  Future<void> create() async {
    var map = getColumnMap();
    id = createUuid();
    map[_columnId] = id;
    map[_columnWordId] = word.id;
    map[_columnImage] = image;
    insert(map);
  }

  @override
  Future<void> readById(String targetId) async {
    final pk = getPrimaryKeys()[0];
    var map = await getRecord({pk: targetId});
    id = map[_columnId];
    word.getRecord({word.getPrimaryKeys()[0]: map[_columnWordId]});
    image = map[_columnImage];
  }

  @override
  Future<void> update() async {
    var map = getColumnMap();
    map[_columnId] = id;
    map[_columnWordId] = word.id;
    map[_columnImage] = image;
    edit(map);
  }

  @override
  Future<void> delete() async {
    destroy({getPrimaryKeys()[0]: id});
  }
}
