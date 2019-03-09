import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/bloc.dart';

void main() {
  Bloc bloc = new Bloc();
  runApp(new MaterialApp(home: new MyApp(bloc), theme: ThemeData.dark()));
}

class MyApp extends StatefulWidget {
  Bloc bloc;

  MyApp(this.bloc);

  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Raspberry System Monitor'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            StreamBuilder(
              stream: widget.bloc.uptime,
              builder: (context, AsyncSnapshot snap) {
                if (snap.hasData) {
                  return Text(snap.data);
                } else
                  return CircularProgressIndicator(
                    semanticsLabel: 'Searching for a Raspberrypi',
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
