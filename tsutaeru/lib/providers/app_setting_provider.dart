import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsutaeru/models/settings.dart';

// @immutable
class AppSetting {
  const AppSetting({required this.fontSize, required this.color});

  final int fontSize;
  final int color;

  AppSetting copyWith({int? fontSize, int? color}) {
    return AppSetting(
      fontSize: fontSize ?? this.fontSize,
      color: color ?? this.color,
    );
  }
}

class AppSettingNotifier extends StateNotifier<AppSetting> {
  AppSettingNotifier()
      : super(const AppSetting(fontSize: 15, color: 0x04bf9dff));

  Future<void> loadFromStorage() async {
    var tmp = Settings();
    await tmp.readById("");

    state = AppSetting(
      color: tmp.primaryColor,
      fontSize: tmp.fontSize,
    );
  }

  Future<void> update({int? fontSize, int? color}) async {
    var newValue = state.copyWith(fontSize: fontSize, color: color);

    var tmp = Settings();
    tmp.primaryColor = newValue.color;
    tmp.fontSize = newValue.fontSize;
    await tmp.update();

    state = newValue;
  }
}

final appSettingProvider =
    StateNotifierProvider<AppSettingNotifier, AppSetting>((ref) {
  return AppSettingNotifier();
});
