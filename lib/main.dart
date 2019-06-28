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

  @override
  void initState() {
    super.initState();
    _dark = false;
    _loadPrefs();
  }

  void _loadPrefs() async {
    if ((Platform.isAndroid) || (Platform.isIOS)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _dark = prefs.getBool('dark') ?? false;
      });
    } else {
      File configFile = File('.config/rasp_mon/config.json');
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
      File configFile = File('.config/rasp_mon/config.json');
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
      title: 'Raspberry System Monitor',
      theme: _dark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Raspberry System Monitor'),
          actions: <Widget>[PowerOffButton(), RebootButton()],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Flexible(child: AddressTile(), flex: 1),
              Flexible(child: LoadAvg(), flex: 4),
              Flexible(child: DiskTile(), flex: 4,),
              Flexible(child: TorrentTile(), flex: 7),
              Flexible(child: TeledartTile(), flex: 2),
              Flexible(child: SambaTile(), flex: 2),
              Flexible(child: SSHTile(), flex: 2),
              Flexible(child: NetatalkTile(), flex: 2)
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Center(child: Text("Impostazioni")),
              ),
              SwitchListTile(
                value: _dark,
                onChanged: _onDarkChanged,
                title: Text('Darkmode'),
              )
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