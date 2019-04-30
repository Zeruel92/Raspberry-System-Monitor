import 'package:flutter/material.dart';

class LoadAvg extends StatefulWidget {
  final Stream stream;
  LoadAvg({this.stream});
  @override
  _LoadAvgState createState() => _LoadAvgState(stream: stream);
}

class _LoadAvgState extends State<LoadAvg> {
  final Stream stream;
  _LoadAvgState({this.stream});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            Color load = Colors.green;
            Color load5 = Colors.green;
            Color load15 = Colors.green;
            Color temp = Colors.green;
            if ((snap.data.loadAvg > 2.0) && (snap.data.loadAvg <= 3.0)) {
              load = Colors.yellow;
            } else if (snap.data.loadAvg > 3.0) {
              load = Colors.red;
            }
            if ((snap.data.loadAvg5 > 2.0) && (snap.data.loadAvg5 <= 3.0)) {
              load5 = Colors.yellow;
            } else if (snap.data.loadAvg5 > 3.0) {
              load5 = Colors.red;
            }
            if ((snap.data.loadAvg15 > 2.0) && (snap.data.loadAvg15 <= 3.0)) {
              load15 = Colors.yellow;
            } else if (snap.data.loadAvg15 > 3.0) {
              load15 = Colors.red;
            }
            if ((snap.data.temp > 50.0) && (snap.data.temp <= 80.0)) {
              temp = Colors.yellow;
            } else if (snap.data.temp > 80.0) {
              temp = Colors.red;
            }
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Uptime: ${snap.data.time}'),
                    Text(
                      'Current load Avarege: ${snap.data.loadAvg}',
                      style: TextStyle(color: load),
                    ),
                    Text(
                      'Last 5 minutes Load Average ${snap.data.loadAvg5}',
                      style: TextStyle(color: load5),
                    ),
                    Text('Last 15 minutes Load Average ${snap.data.loadAvg15}',
                        style: TextStyle(color: load15)),
                    Text('System Core temperature ${snap.data.temp} °C',
                        style: TextStyle(color: temp))
                  ],
                ),
              ),
            );
          } else
            return Container(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Searching RaspberryPi in your Local Network.....')
                ],
              ),
            ));
        },
      ),
    );
  }
}

class PowerOffButton extends StatelessWidget {
  final Sink sink;

  PowerOffButton({this.sink});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: _powerOff,
    );
  }

  void _powerOff() => sink.add(true);
}

class RebootButton extends StatelessWidget {
  final Sink sink;

  RebootButton({this.sink});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: _reboot,
    );
  }

  void _reboot() => sink.add(true);
}

class TorrentTile extends StatefulWidget {
  final Stream stream;
  final Sink sink;
  TorrentTile({this.stream, this.sink});
  @override
  _TorrentTileState createState() =>
      _TorrentTileState(stream: stream, sink: sink);
}

class _TorrentTileState extends State<TorrentTile> {
  final Stream stream;
  final Sink sink;
  _TorrentTileState({this.stream, this.sink});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Text(snap.data.torrentStatus),
                  Switch(
                    value: snap.data.running,
                    onChanged: _setTorrent,
                  ),
                  snap.data.running ? Text('Torrent On') : Text('Torrent Off')
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _setTorrent(bool t) => sink.add(t);
}

class TeledartTile extends StatefulWidget {
  final Stream stream;
  final Sink sink;
  TeledartTile({this.stream, this.sink});
  @override
  _TeledartTileState createState() =>
      _TeledartTileState(stream: stream, sink: sink);
}

class _TeledartTileState extends State<TeledartTile> {
  final Stream stream;
  final Sink sink;
  _TeledartTileState({this.stream, this.sink});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Icon(Icons.send),
                  Switch(
                    value: snap.data.running,
                    onChanged: _setTeledart,
                  ),
                  snap.data.running ? Text('Teledart On') : Text('Teledart Off')
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _setTeledart(bool t) => sink.add(t);
}

class AddressTile extends StatefulWidget {
  final Stream stream;
  AddressTile({this.stream});
  @override
  _AddressTileState createState() => _AddressTileState(stream: stream);
}

class _AddressTileState extends State<AddressTile> {
  final Stream stream;
  _AddressTileState({this.stream});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[Text('Connesso a: ${snap.data.address}')],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class SambaTile extends StatefulWidget {
  final Stream stream;
  final Sink sink;

  SambaTile({this.stream, this.sink});

  @override
  _SambaTileState createState() => _SambaTileState(stream: stream, sink: sink);
}

class _SambaTileState extends State<SambaTile> {
  final Stream stream;
  final Sink sink;

  _SambaTileState({this.stream, this.sink});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Icon(Icons.people_outline),
                  Switch(
                    value: snap.data.running,
                    onChanged: _setSamba,
                  ),
                  snap.data.running ? Text('Samba On') : Text('Samba Off')
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _setSamba(bool t) => sink.add(t);
}

class SSHTile extends StatefulWidget {
  final Stream stream;
  final Sink sink;
  SSHTile({this.stream, this.sink});
  @override
  _SSHTileState createState() => _SSHTileState(stream: stream, sink: sink);
}

class _SSHTileState extends State<SSHTile> {
  final Stream stream;
  final Sink sink;
  _SSHTileState({this.stream, this.sink});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Icon(Icons.people_outline),
                  Switch(
                    value: snap.data.running,
                    onChanged: _setSSH,
                  ),
                  snap.data.running ? Text('SSH On') : Text('SSH Off')
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _setSSH(bool t) => sink.add(t);
}

class NetatalkTile extends StatefulWidget {
  final Stream stream;
  final Sink sink;
  NetatalkTile({this.stream, this.sink});
  @override
  _NetatalkTileState createState() =>
      _NetatalkTileState(stream: stream, sink: sink);
}

class _NetatalkTileState extends State<NetatalkTile> {
  final Stream stream;
  final Sink sink;
  _NetatalkTileState({this.stream, this.sink});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Icon(Icons.people_outline),
                  Switch(
                    value: snap.data.running,
                    onChanged: _setNetatalk,
                  ),
                  snap.data.running ? Text('Netatalk On') : Text('Netatalk Off')
                ],
              ),
            ),
          );
        } else {
          return Card(child: Placeholder());
        }
      },
    );
  }

  void _setNetatalk(bool t) => sink.add(t);
}
