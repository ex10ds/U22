import 'package:flutter/material.dart';
import 'package:tsutaeru/init_process.dart';
import 'package:tsutaeru/models/settings.dart';
import 'package:tsutaeru/widgets/group_list.dart';

class LaunchApp extends StatefulWidget {
  const LaunchApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State {
  late Widget _screen = const SplashWidget();

  int _color = 0x04bf9dff;
  int _fontSize = 15;
  Future<void> setSettings() async {
    var tmp = Settings();
    await tmp.readById("");
    setState(() {
      _color = tmp.primaryColor;
      _fontSize = tmp.fontSize;
    });
  }

  @override
  void initState() {
    super.initState();
    launchApp();
  }

  Future<void> launchApp() async {
    // create database
    await initProcess();
    await setSettings();
    setState(() {
      // first widget in this application
      _screen = const GroupList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Color(_color)),
            textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: _fontSize.toDouble()),
                bodyText2: TextStyle(fontSize: _fontSize.toDouble()))),
        home: _screen);
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  // splash screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/logo_wide.png')]),
        ),
      ),
    );
  }
}
