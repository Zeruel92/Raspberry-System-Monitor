import 'dart:io';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/bloc.dart';

import 'home.dart';
import 'landing.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Bloc.instance.theme.stream,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: Platform.isLinux ? false : true,
            title: 'Raspberry System Monitor',
            theme:
                snapshot.data ?? false ? ThemeData.dark() : ThemeData.light(),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            initialRoute: '/landing',
            routes: {
              '/home': (context) => Home(),
              '/landing': (context) => Landing()
            },
          );
        });
  }

  @override
  void dispose() {
    Bloc.instance.close();
    super.dispose();
  }
}
