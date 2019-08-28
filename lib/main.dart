import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widget.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(MyApp());
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
  bool _dark;
  GlobalKey<ScaffoldState> _scaffoldState;

  @override
  void initState() {
    super.initState();
    _dark = false;
    _loadPrefs();
    _scaffoldState = GlobalKey<ScaffoldState>();
    Bloc.instance.setScaffoldState(_scaffoldState);
  }

  void _loadPrefs() async {
    if ((Platform.isAndroid) || (Platform.isIOS)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _dark = prefs.getBool('dark') ?? false;
      });
    } else {
      Map<String, String> envVars = Platform.environment;
      File configFile;
      if (envVars['SNAP_USER_DATA'] != null)
        configFile =
            File('${envVars['SNAP_USER_DATA']}/.config/rasp_mon/config.json');
      else
        configFile = File('.config/rasp_mon/config.json');
      if (configFile.existsSync()) {
        Map config = json.decode(configFile.readAsStringSync());
        setState(() {
          _dark = config['dark'] ?? false;
        });
      }
      else
        setState(() {
          _dark = false;
        });
    }
  }

  void _onDarkChanged(bool changed) async {
    setState(() => _dark = changed);
    if ((Platform.isAndroid) || (Platform.isIOS)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('dark', _dark);
    } else {
      Map<String, String> envVars = Platform.environment;
      File configFile;
      if (envVars['SNAP_USER_DATA'] != null)
        configFile =
            File('${envVars['SNAP_USER_DATA']}/.config/rasp_mon/config.json');
      else
        configFile = File('.config/rasp_mon/config.json');
      Map config = {};
      config['dark'] = _dark;
      if (!configFile.existsSync())
        configFile.createSync(recursive: true);
      configFile.writeAsBytes(utf8.encode(json.encode(config)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Platform.isLinux ? false : true,
      title: 'Raspberry System Monitor',
      theme: _dark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
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
              Flexible(child: DiskTile(), flex: 2,),
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
              GestureDetector(
                onTap: () => _onDarkChanged(!_dark),
                child: Card(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.format_paint),
                        Switch(
                          value: _dark,
                          onChanged: _onDarkChanged,
                        ),
                        _dark ? Text('Dark Theme') : Text('Light Theme')
                      ],
                    )
                ),
              ),
              Divider(),
              TeledartTile(),
              SambaTile(),
              SSHTile(),
              NetatalkTile(),
              TorrentTile()
            ],
          ),
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