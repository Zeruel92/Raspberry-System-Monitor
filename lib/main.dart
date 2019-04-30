import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:raspberry_system_monitor/blocs/bloc.dart';
import 'widget.dart';

void main() {
  Bloc bloc = new Bloc();
  _setTargetPlatformForDesktop();
  runApp(MaterialApp(home: MyApp(bloc: bloc), theme: ThemeData.dark()));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Raspberry System Monitor'),
        actions: <Widget>[
          PowerOffButton(sink: widget.bloc.poweroff.sink),
          RebootButton(sink: widget.bloc.reboot.sink)
        ],
      ),
      body: Center(
        child: Column(
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
            ),
            SambaTile(
              stream: widget.bloc.samba.stream,
              sink: widget.bloc.samba.sink,
            ),
            SSHTile(
              stream: widget.bloc.ssh.stream,
              sink: widget.bloc.ssh.sink,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }
}

/* From stack overflow snippet to check if in debug mode
*
Here is a simple solution to this:

import 'package:flutter/foundation.dart';
then you can use kReleaseMode like

if(kReleaseMode){ // is Release Mode ??
    print('release mode');
} else {
    print('debug mode');
}

*/

//TODO adding support for netatalk
//TODO use static address in debug for test (maybe is usefull in emulator °L°)
//TODO make main column scrollable
