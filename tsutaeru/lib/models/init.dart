import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/image.dart';
import 'package:tsutaeru/models/word_belonging.dart';
import 'package:tsutaeru/models/word_group.dart';
import 'package:tsutaeru/models/words.dart';

initDatabase() {
  Color();
  WordGroup();
  Word();
  Image();
  WordBelonging();
}
