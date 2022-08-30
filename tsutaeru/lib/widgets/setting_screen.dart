import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsutaeru/models/settings.dart';
import 'package:tsutaeru/providers/app_setting_provider.dart';
import 'package:tsutaeru/values/colors.dart';
import 'package:tsutaeru/values/strings.dart';

// class SettingScreen extends StatelessWidget {
//   const SettingScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text(AppString.setting)),
//       body: Column(
//         children: [],
//       ),
//     );
//   }
// }

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends ConsumerState<SettingScreen> {
  List<int> _colors = [];
  // int _nowColor = 0x04bf9dff;
  // int _fontSizeValue = 15;

  @override
  void initState() {
    super.initState();

    setState(() {
      _colors = AppDisplayColor().displayColors;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appSetting = ref.watch(appSettingProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(AppString.setting)),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                  child: DropdownButton<int>(
                      value: appSetting.color,
                      items: [
                        ..._colors
                            .asMap()
                            .entries
                            .map((entry) => DropdownMenuItem<int>(
                                value: entry.value,
                                child: Container(
                                  color: Color(entry.value),
                                  width: 100,
                                  height: 100,
                                )))
                            .toList(),
                      ],
                      onChanged: (value) {
                        ref
                            .read(appSettingProvider.notifier)
                            .update(color: value!);
                      }))),
          SizedBox(
              width: double.infinity,
              height: 200,
              child: Center(
                child: Text("font size",
                    style: TextStyle(fontSize: appSetting.fontSize.toDouble())),
              )),
          Slider(
              min: 15,
              max: 30,
              divisions: 17,
              value: appSetting.fontSize.roundToDouble(),
              label: appSetting.fontSize.toString(),
              onChanged: (value) {
                ref
                    .read(appSettingProvider.notifier)
                    .update(fontSize: value.round());
              }),
        ],
      ),
    );
  }
}
