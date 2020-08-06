import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/pihole.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class PiholeBloc {
  late BehaviorSubject<Pihole> _subject;
  late BehaviorSubject<bool> _toggleSubject;

  late Stream _stream;
  late String _addressString;

  late Sink _tSink;
  late Sink _piholeSink;

  Stream? _address;

  Stream get stream => _stream;

  Sink get sink => _tSink;

  PiholeBloc(Stream? address) {
    _subject =
        BehaviorSubject.seeded(Pihole((pihole) => pihole..running = false));
    _toggleSubject = BehaviorSubject();
    _tSink = _toggleSubject.sink;
    _stream = _subject.stream;
    _piholeSink = _subject.sink;
    _toggleSubject.listen(_toggleListener);
    _address = address;
    _address?.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _toggleListener(toggle) async {
    try {
      await http.post('http://$_addressString:8888/pihole/$toggle');
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void _update(String address) async {
    _addressString = address;
    try {
      final res = await http.get('http://$_addressString:8888/pihole/1');
      _piholeSink.add(Pihole.fromJson(res.body));
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void close() {
    _tSink.close();
    _piholeSink.close();
    _subject.close();
    _toggleSubject.close();
  }
}
