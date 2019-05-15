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
            Flexible(child: AddressTile(stream: widget.bloc.address), flex: 2),
            Flexible(
                child: LoadAvg(stream: widget.bloc.uptime.stream), flex: 4),
            Flexible(
              child: TorrentTile(
                stream: widget.bloc.torrent.stream,
                sink: widget.bloc.torrent.sink,
              ),
              flex: 5,
            ),
            Flexible(
              child: TeledartTile(
                stream: widget.bloc.teledart.stream,
                sink: widget.bloc.teledart.sink,
              ),
              flex: 2,
            ),
            Flexible(
                child: SambaTile(
                  stream: widget.bloc.samba.stream,
                  sink: widget.bloc.samba.sink,
                ),
                flex: 2),
            Flexible(
              child: SSHTile(
                stream: widget.bloc.ssh.stream,
                sink: widget.bloc.ssh.sink,
              ),
              flex: 2,
            ),
            Flexible(
              child: NetatalkTile(
                stream: widget.bloc.apfs.stream,
                sink: widget.bloc.apfs.sink,
              ),
              flex: 2,
            )
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
