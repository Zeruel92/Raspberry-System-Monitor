import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/samba.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class SambaBloc {
  late BehaviorSubject<Samba> _subject;
  late BehaviorSubject<bool> _toggleSubject;

  late Stream _stream;
  late String _addressString;

  late Sink _tSink;
  late Sink _sambaSink;

  Stream? _address;

  Stream get stream => _stream;

  Sink get sink => _tSink;

  SambaBloc(Stream address) {
    _subject = BehaviorSubject.seeded(Samba((samba) => samba..running = false));
    _toggleSubject = BehaviorSubject();
    _tSink = _toggleSubject.sink;
    _stream = _subject.stream;
    _sambaSink = _subject.sink;
    _toggleSubject.listen(_sambaToggleListener);
    _address = address;
    _address?.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _sambaToggleListener(toggle) async {
    try {
      await http.post('http://$_addressString:8888/smb/$toggle');
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void _update(String address) async {
    _addressString = address;
    try {
      final res = await http.get('http://$_addressString:8888/smb/1');
      _sambaSink.add(Samba.fromJson(res.body));
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void close() {
    _tSink.close();
    _sambaSink.close();
    _toggleSubject.close();
    _subject.close();
  }
}
