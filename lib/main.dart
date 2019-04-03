import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:raspberry_system_monitor/blocs/bloc.dart';
import 'widget.dart';

void main() {
  Bloc bloc = new Bloc();
  _setTargetPlatformForDesktop();
  runApp(new MaterialApp(home: new MyApp(bloc: bloc), theme: ThemeData.dark()));
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
  final Bloc bloc;

  MyApp({this.bloc});

  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Raspberry System Monitor'),
        actions: <Widget>[
          PowerOffButton(sink: widget.bloc.poweroff.sink),
          RebootButton(
            sink: widget.bloc.reboot.sink,
          )
        ],
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            AddressTile(stream: widget.bloc.address),
            LoadAvg(stream: widget.bloc.uptime.stream),
            TorrentTile(
              stream: widget.bloc.torrent.stream,
              sink: widget.bloc.torrent.sink,
            ),
            TeledartTile(
              stream: widget.bloc.teledart.stream,
              sink: widget.bloc.teledart.sink,
            )
          ],
        ),
      ),
    );
  }
}
