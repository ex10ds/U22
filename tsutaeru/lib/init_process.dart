import 'package:tsutaeru/models/color.dart';
import 'package:tsutaeru/models/init.dart';
import 'package:tsutaeru/values/colors.dart';

Future<void> initProcess() async {
  await initDatabase();
}

Future<Color> insertDefaultColor() async {
  Color defaultColor = Color();
  defaultColor.id = "default_color";
  defaultColor.textColor = AppColor.defaultTextColor;
  defaultColor.backgroundColor = AppColor.defaultBackgroungColor;
  defaultColor.create();

  return defaultColor;
}
