import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/bloc.dart';
import 'widget.dart';

void main() {
  Bloc bloc = new Bloc();
  runApp(new MaterialApp(home: new MyApp(bloc: bloc), theme: ThemeData.dark()));
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
          PowerOffButton(powerOffSink: widget.bloc.powerOff),
          RebootButton(
            rebootSink: widget.bloc.reboot,
          )
        ],
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            LoadAvg(uptimeStream: widget.bloc.uptime),
            TorrentTile(
              torrent: widget.bloc.torrent,
              toggle: widget.bloc.torrentToggleSink,
            )
          ],
        ),
      ),
    );
  }
}
