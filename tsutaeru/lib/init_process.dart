import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/image.dart';
import 'package:tsutaeru/models/init.dart';
import 'package:tsutaeru/models/phrase.dart';
import 'package:tsutaeru/models/phrase_group.dart';
import 'package:tsutaeru/values/colors.dart';

Future<void> initProcess() async {
  await initDatabase();

  //////// for develop ////////
  // delete all records
  for (var e in await Color().readAll()) {
    await e.delete();
  }
  for (var e in await Image().readAll()) {
    await e.delete();
  }
  for (var e in await PhraseGroup().readAll()) {
    await e.delete();
  }
  for (var e in await Phrase().readAll()) {
    await e.delete();
  }

  // initialized color preset
  Color color1 = await insertDefaultColor();

  // create phrases
  Phrase phrase1 = Phrase();
  phrase1.text = "Sample phrase 1";
  phrase1.color = color1;
  await phrase1.create();

  Phrase phrase2 = Phrase();
  phrase2.text = "Sample phrase 2";
  phrase2.color = color1;
  await phrase2.create();

  // create phrase groups
  PhraseGroup group1 = PhraseGroup();
  group1.name = "Sample Group 1";
  group1.phrases.add(phrase1);
  await group1.create();

  PhraseGroup group2 = PhraseGroup();
  group2.name = "Sample Group 2";
  group2.phrases.add(phrase2);
  await group2.create();
  ////////////////////////////
}

Future<Color> insertDefaultColor() async {
  Color defaultColor = Color();
  defaultColor.id = "default_color";
  defaultColor.textColor = defaultTextColor;
  defaultColor.backgroundColor = defaultBackgroungColor;
  defaultColor.create();

  return defaultColor;
}
