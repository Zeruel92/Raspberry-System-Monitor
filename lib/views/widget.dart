import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/bloc.dart';

class LoadAvg extends StatefulWidget {
  @override
  _LoadAvgState createState() => _LoadAvgState();
}

class _LoadAvgState extends State<LoadAvg> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Bloc.instance.uptime.stream,
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
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Uptime: ${snap.data.time}'),
                      Text(
                        'Current load Avarege: ${snap.data.loadAvg}',
                        style: TextStyle(color: load),
                      ),
                      Text(
                        'Last 5 minutes Load Average: ${snap.data.loadAvg5}',
                        style: TextStyle(color: load5),
                      ),
                      Text(
                          'Last 15 minutes Load Average: ${snap.data.loadAvg15}',
                          style: TextStyle(color: load15)),
                      Text('System Core temperature: ${snap.data.temp} °C',
                          style: TextStyle(color: temp))
                    ],
                  ),
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
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.power_settings_new),
      onPressed: _powerOff,
      tooltip: 'Turn off Raspberrypi System',
    );
  }

  void _powerOff() => Bloc.instance.poweroff.sink.add(true);
}

class RebootButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: _reboot,
        tooltip: 'Reboot Raspberrypi System');
  }

  void _reboot() => Bloc.instance.reboot.sink.add(true);
}

class TorrentTile extends StatefulWidget {
  @override
  _TorrentTileState createState() => _TorrentTileState();
}

class _TorrentTileState extends State<TorrentTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.torrent.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return GestureDetector(
            onTap: () => _setTorrent(!snap.data.running),
            child: Card(
              child: Row(
                children: <Widget>[
                  Icon(Icons.file_download),
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

  void _setTorrent(bool t) => Bloc.instance.torrent.sink.add(t);
}

class TeledartTile extends StatefulWidget {
  @override
  _TeledartTileState createState() => _TeledartTileState();
}

class _TeledartTileState extends State<TeledartTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.teledart.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return GestureDetector(
            onTap: () => _setTeledart(!snap.data.running),
            child: Card(
              child: Row(
                children: <Widget>[
                  Icon(Icons.send),
                  Switch(value: snap.data.running, onChanged: _setTeledart),
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

  void _setTeledart(bool t) => Bloc.instance.teledart.sink.add(t);
}

class AddressTile extends StatefulWidget {
  @override
  _AddressTileState createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.address,
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
  @override
  _SambaTileState createState() => _SambaTileState();
}

class _SambaTileState extends State<SambaTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.samba.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return GestureDetector(
            onTap: () => _setSamba(!snap.data.running),
            child: Card(
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

  void _setSamba(bool t) => Bloc.instance.samba.sink.add(t);
}

class SSHTile extends StatefulWidget {
  @override
  _SSHTileState createState() => _SSHTileState();
}

class _SSHTileState extends State<SSHTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.ssh.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return GestureDetector(
            onTap: () => _setSSH(!snap.data.running),
            child: Card(
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

  void _setSSH(bool t) => Bloc.instance.ssh.sink.add(t);
}

class NetatalkTile extends StatefulWidget {
  @override
  _NetatalkTileState createState() => _NetatalkTileState();
}

class _NetatalkTileState extends State<NetatalkTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.apfs.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return GestureDetector(
            onTap: () => _setNetatalk(!snap.data.running),
            child: Card(
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

  void _setNetatalk(bool t) => Bloc.instance.apfs.sink.add(t);
}

class DiskTile extends StatefulWidget {
  @override
  _DiskTileState createState() => _DiskTileState();
}

class _DiskTileState extends State<DiskTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.disk.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Card(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[Text('${snap.data.df}')],
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

class TorrentStats extends StatefulWidget {
  @override
  _TorrentStatsState createState() => _TorrentStatsState();
}

class _TorrentStatsState extends State<TorrentStats> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.torrent.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return (snap.data.torrentStatus != '')
              ? Card(
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text('${snap.data.torrentStatus}')))
              : Container();
        } else {
          return Container();
        }
      },
    );
  }
}

class PiholeTile extends StatefulWidget {
  @override
  _PiholeTileState createState() => _PiholeTileState();
}

class _PiholeTileState extends State<PiholeTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.instance.pihole.stream,
      builder: (context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return GestureDetector(
            onTap: () => _setPihole(!snap.data.running),
            child: Card(
              child: Row(
                children: <Widget>[
                  Icon(Icons.block),
                  Switch(
                    value: snap.data.running,
                    onChanged: _setPihole,
                  ),
                  snap.data.running ? Text('Pihole On') : Text('Pihole Off')
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

  void _setPihole(bool t) => Bloc.instance.pihole.sink.add(t);
}
