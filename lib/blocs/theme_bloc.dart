import 'dart:convert';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc {
  BehaviorSubject<bool> _dark;
  Stream _stream;
  Sink _sink;

  Stream get stream => _stream;

  Sink get sink => _sink;

  ThemeBloc() {
    _dark = BehaviorSubject.seeded(false);
    _sink = _dark.sink;
    _stream = _dark.stream;
    _dark.listen((value) => _onDarkChanged);
  }

  void _onDarkChanged(bool changed) async {
    if ((Platform.isAndroid) || (Platform.isIOS)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('dark', changed);
    } else {
      Map<String, String> envVars = Platform.environment;
      File configFile;
      if (envVars['SNAP_USER_DATA'] != null)
        configFile =
            File('${envVars['SNAP_USER_DATA']}/.config/rasp_mon/config.json');
      else
        configFile = File('.config/rasp_mon/config.json');
      Map config = {};
      config['dark'] = changed;
      if (!configFile.existsSync()) configFile.createSync(recursive: true);
      configFile.writeAsBytes(utf8.encode(json.encode(config)));
    }
  }

  void _loadPrefs() async {
    if ((Platform.isAndroid) || (Platform.isIOS)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      sink.add(prefs.getBool('dark') ?? false);
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
        sink.add(config['dark'] ?? false);
      } else
        sink.add(false);
    }
  }
}
