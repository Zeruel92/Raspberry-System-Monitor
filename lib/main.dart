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
            Flexible(child: AddressTile(), flex: 3),
            Flexible(child: LoadAvg(), flex: 6),
            Flexible(child: DiskTile(), flex: 5,),
            Flexible(
              child: TorrentTile(),
              flex: 9,
            ),
            Flexible(
              child: TeledartTile(),
              flex: 4,
            ),
            Flexible(child: SambaTile(), flex: 4),
            Flexible(
              child: SSHTile(),
              flex: 4,
            ),
            Flexible(
              child: NetatalkTile(),
              flex: 4,
            )
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

//TODO: adding torrent page
//TODO: adding disk space infos
