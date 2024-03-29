import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/image.dart';
import 'package:tsutaeru/models/phrase_belonging.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/models/settings.dart';
import 'package:tsutaeru/values/internal.dart';
import 'package:tsutaeru/values/colors.dart';

Future<void> initDatabase() async {
  await openDatabase(join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) async {
    await db.execute(Settings().tableSchema.getCreateTableSql());
    await db.execute(Color().tableSchema.getCreateTableSql());
    await db.execute(PhraseGroup().tableSchema.getCreateTableSql());
    await db.execute(Phrase().tableSchema.getCreateTableSql());
    await db.execute(Image().tableSchema.getCreateTableSql());
    await db.execute(UnsafePhraseBelonging().tableSchema.getCreateTableSql());
  }, version: databaseVersion);

  Color defaultColor = Color();
  defaultColor.id = "default_color";
  defaultColor.textColor = AppColor.defaultTextColor;
  defaultColor.backgroundColor = AppColor.defaultBackgroungColor;
  defaultColor.create();

  Settings setting = Settings();
  await setting.check();
}
