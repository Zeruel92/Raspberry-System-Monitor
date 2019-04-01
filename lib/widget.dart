import 'package:flutter/material.dart';

class LoadAvg extends StatefulWidget {
  final Stream uptimeStream;
  LoadAvg({this.uptimeStream});
  @override
  _LoadAvgState createState() => _LoadAvgState(uptimeStream: uptimeStream);
}

class _LoadAvgState extends State<LoadAvg> {
  final Stream uptimeStream;

  _LoadAvgState({this.uptimeStream});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: uptimeStream,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            Color load = Colors.green;
            Color load5 = Colors.green;
            Color load15 = Colors.green;
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
                        style: TextStyle(color: load15))
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
  final Sink powerOffSink;

  PowerOffButton({this.powerOffSink});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: _powerOff,
    );
  }

  void _powerOff() => powerOffSink.add(true);
}

class RebootButton extends StatelessWidget {
  final Sink rebootSink;

  RebootButton({this.rebootSink});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: _reboot,
    );
  }

  void _reboot() => rebootSink.add(true);
}

class TorrentTile extends StatefulWidget {
  final Stream torrent;
  final Sink toggle;
  TorrentTile({this.torrent, this.toggle});
  @override
  _TorrentTileState createState() =>
      _TorrentTileState(torrent: torrent, toggle: toggle);
}

class _TorrentTileState extends State<TorrentTile> {
  final Stream torrent;
  final Sink toggle;
  _TorrentTileState({this.torrent, this.toggle});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: torrent,
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

  void _setTorrent(bool t) {
    toggle.add(t);
  }
}

class TeledartTile extends StatefulWidget {
  final Stream teledart;
  final Sink teledartSink;
  TeledartTile({this.teledart, this.teledartSink});
  @override
  _TeledartTileState createState() =>
      _TeledartTileState(teledart: teledart, teledartSink: teledartSink);
}

class _TeledartTileState extends State<TeledartTile> {
  final Stream teledart;
  final Sink teledartSink;
  _TeledartTileState({this.teledart, this.teledartSink});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: teledart,
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

  void _setTeledart(bool t) {
    teledartSink.add(t);
  }
}
