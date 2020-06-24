import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/bloc.dart';

import 'widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldState;

  @override
  void initState() {
    super.initState();
    _scaffoldState = GlobalKey<ScaffoldState>();
    Bloc.instance.setScaffoldState(_scaffoldState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Raspberry System Monitor'),
        actions: <Widget>[PowerOffButton(), RebootButton()],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(child: AddressTile(), flex: 1),
            Flexible(child: LoadAvg(), flex: 2),
            Flexible(
              child: DiskTile(),
              flex: 2,
            ),
            Flexible(child: TorrentStats(), flex: 5),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text("Impostazioni")),
            ),
            StreamBuilder<bool>(
                stream: Bloc.instance.theme.stream,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () => Bloc.instance.theme.sink.add(!snapshot.data),
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.format_paint),
                          Switch(
                            value: snapshot.data ?? false,
                            onChanged: Bloc.instance.theme.sink.add,
                          ),
                          snapshot.data ?? false
                              ? Text('Dark Theme')
                              : Text('Light Theme')
                        ],
                      ),
                    ),
                  );
                }),
            Divider(),
            TeledartTile(),
            SambaTile(),
            SSHTile(),
            NetatalkTile(),
            TorrentTile(),
            PiholeTile()
          ],
        ),
      ),
    );
  }
}
