import 'dart:io';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/bloc.dart';

import 'widget.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(
    MaterialApp(
      home: MyApp(),
      theme: ThemeData.dark(),
      title: 'Raspberrypi System Monitor',
    ),
  );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raspberry System Monitor'),
        actions: <Widget>[PowerOffButton(), RebootButton()],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(child: AddressTile(), flex: 2),
            Flexible(child: LoadAvg(), flex: 6),
            Flexible(child: DiskTile(), flex: 6,),
            Flexible(
              child: TorrentTile(),
              flex: 9,
            ),
            Flexible(
              child: TeledartTile(),
              flex: 3,
            ),
            Flexible(child: SambaTile(), flex: 3),
            Flexible(child: SSHTile(), flex: 3),
            Flexible(child: NetatalkTile(), flex: 3)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Bloc.instance.close();
    super.dispose();
  }
}

