import 'package:flutter/material.dart';
import 'package:tsutaeru/models/settings.dart';
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

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late List<int> _colors;
  int? _nowColor;
  int _fontSizeValue = 15;

  Future<void> _updateColor(value) async {
    setState(() {
      _nowColor = value;
    });
    var tmp = Settings();
    tmp.primaryColor = value;
    tmp.update();
  }

  Future<void> _updateFontSize(value) async {
    setState(() {
      _fontSizeValue = value.toInt();
    });
    var tmp = Settings();
    tmp.fontSize = value.toInt();
    tmp.update();
  }

  Future<void> setSettings() async {
    _colors = AppDisplayColor().displayColors;
    var tmp = Settings();
    await tmp.readById("");
    setState(() {
      _nowColor = tmp.primaryColor;
      _fontSizeValue = tmp.fontSize;
    });
  }

  @override
  void initState() {
    super.initState();
    setSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppString.setting)),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                  child: DropdownButton<int>(
                      value: _nowColor,
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
                        _updateColor(value!);
                      }))),
          SizedBox(
              width: double.infinity,
              height: 200,
              child: Center(
                child: Text("font size",
                    style: TextStyle(fontSize: _fontSizeValue.toDouble())),
              )),
          Slider(
              min: 15,
              max: 30,
              divisions: 15,
              value: _fontSizeValue.toDouble(),
              label: _fontSizeValue.round().toString(),
              onChanged: (value) {
                _updateFontSize(value);
              })
        ],
      ),
    );
  }
}
