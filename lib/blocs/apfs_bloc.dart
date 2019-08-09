import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/apfs.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class NetAtalkBloc {
  BehaviorSubject<NetAtalk> _subject;
  BehaviorSubject<bool> _toggleSubject;

  Stream _stream;
  String _addressString;

  Sink _tSink;
  Sink _apfsSink;

  Stream _address;

  Stream get stream => _stream;

  Sink get sink => _tSink;

  NetAtalkBloc(Stream address) {
    _subject =
    new BehaviorSubject.seeded(NetAtalk((apfs) => apfs..running = false));
    _toggleSubject = new BehaviorSubject();
    _tSink = _toggleSubject.sink;
    _stream = _subject.stream;
    _apfsSink = _subject.sink;
    _toggleSubject.listen(_afpToggleListener);
    _address = address;
    _address.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _afpToggleListener(toggle) async {
    try {
      await http.post('http://$_addressString:8888/netatalk/$toggle');
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(
          SnackBar(content: Text('${e.toString()}'),));
    }
  }

  void _update(String address) async {
    _addressString = address;
    try {
      final res = await http.get('http://$_addressString:8888/netatalk/1');
      _apfsSink.add(NetAtalk.fromJson(res.body));
    }catch(e){
      Bloc.instance.scaffold.showSnackBar(
          SnackBar(content: Text('${e.toString()}'),));
    }
  }

  void close() {
    _tSink.close();
    _apfsSink.close();
    _subject.close();
    _toggleSubject.close();
  }
}
