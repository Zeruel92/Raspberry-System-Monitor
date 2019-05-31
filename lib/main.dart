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
        actions: <Widget>[
          PowerOffButton(sink: Bloc.instance.poweroff.sink),
          RebootButton(sink: Bloc.instance.reboot.sink)
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
                child: AddressTile(stream: Bloc.instance.address), flex: 2),
            Flexible(
                child: LoadAvg(stream: Bloc.instance.uptime.stream), flex: 4),
            Flexible(
              child: TorrentTile(
                stream: Bloc.instance.torrent.stream,
                sink: Bloc.instance.torrent.sink,
              ),
              flex: 6,
            ),
            Flexible(
              child: TeledartTile(
                stream: Bloc.instance.teledart.stream,
                sink: Bloc.instance.teledart.sink,
              ),
              flex: 3,
            ),
            Flexible(
                child: SambaTile(
                  stream: Bloc.instance.samba.stream,
                  sink: Bloc.instance.samba.sink,
                ),
                flex: 3),
            Flexible(
              child: SSHTile(
                stream: Bloc.instance.ssh.stream,
                sink: Bloc.instance.ssh.sink,
              ),
              flex: 3,
            ),
            Flexible(
              child: NetatalkTile(
                stream: Bloc.instance.apfs.stream,
                sink: Bloc.instance.apfs.sink,
              ),
              flex: 3,
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
