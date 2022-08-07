import 'package:flutter/material.dart';
import 'package:tsutaeru/init_process.dart';
import 'package:tsutaeru/values/strings.dart';
import 'package:tsutaeru/widgets/group_list.dart';

class LaunchApp extends StatefulWidget {
  const LaunchApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State {
  late Widget _screen = const SplashWidget();

  @override
  void initState() {
    super.initState();
    launchApp();
  }

  Future<void> launchApp() async {
    // create database
    await initProcess();

    setState(() {
      // first widget in this application
      _screen = const GroupList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _screen;
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
              children: const [FlutterLogo(), Text(appName)]),
        ),
      ),
    );
  }
}
