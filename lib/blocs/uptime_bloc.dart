import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/uptime.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class UptimeBloc {
  late BehaviorSubject<Uptime> _uptimeSubject;

  late Sink _sinkUptime;

  late Stream _uptimeStream;
  Stream? _address;

  Stream get stream => _uptimeStream;

  UptimeBloc(Stream? address) {
    _uptimeSubject = BehaviorSubject();
    _sinkUptime = _uptimeSubject.sink;
    _uptimeStream = _uptimeSubject.stream;
    _address = address;
    _address?.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _update(String address) async {
    try {
      final res = await http.get('http://$address:8888/uptime');
      _sinkUptime.add(Uptime.fromJson(res.body));
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void close() {
    _uptimeSubject.close();
    _sinkUptime.close();
  }
}
