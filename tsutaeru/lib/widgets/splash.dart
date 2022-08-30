import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsutaeru/init_process.dart';
import 'package:tsutaeru/providers/app_setting_provider.dart';
import 'package:tsutaeru/widgets/group_list.dart';

class LaunchApp extends ConsumerStatefulWidget {
  const LaunchApp({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends ConsumerState<LaunchApp> {
  late Widget _screen = const SplashWidget();

  @override
  void initState() {
    super.initState();
    launchApp();
  }

  Future<void> launchApp() async {
    // create database
    await initProcess();
    await ref.read(appSettingProvider.notifier).loadFromStorage();

    setState(() {
      // first widget in this application
      _screen = const GroupList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appSetting = ref.watch(appSettingProvider);
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(color: Color(appSetting.color)),
            textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: appSetting.fontSize.toDouble()),
                bodyText2:
                    TextStyle(fontSize: appSetting.fontSize.toDouble()))),
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
