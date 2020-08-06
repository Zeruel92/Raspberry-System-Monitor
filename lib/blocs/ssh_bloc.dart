import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/ssh.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class SSHBloc {
  late BehaviorSubject<SSHStatus> _subject;
  late BehaviorSubject<bool> _toggleSubject;

  late Stream _stream;
  late String _addressString;

  late Sink _tSink;
  late Sink _sshSink;

  Stream? _address;

  Stream get stream => _stream;

  Sink get sink => _tSink;

  SSHBloc(Stream? address) {
    _subject = BehaviorSubject.seeded(SSHStatus((ssh) => ssh..running = false));
    _toggleSubject = BehaviorSubject();
    _tSink = _toggleSubject.sink;
    _stream = _subject.stream;
    _sshSink = _subject.sink;
    _toggleSubject.listen(_sshToggleListener);
    _address = address;
    _address?.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _sshToggleListener(toggle) async {
    try {
      await http.post('http://$_addressString:8888/ssh/$toggle');
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void _update(String address) async {
    _addressString = address;
    try {
      final res = await http.get('http://$_addressString:8888/ssh/1');
      _sshSink.add(SSHStatus.fromJson(res.body));
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(SnackBar(
        content: Text('${e.toString()}'),
      ));
    }
  }

  void close() {
    _tSink.close();
    _sshSink.close();
    _subject.close();
    _toggleSubject.close();
  }
}
