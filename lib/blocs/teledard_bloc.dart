import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/teledart.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class TeledartBloc {
  late BehaviorSubject<Teledart> _teledartSubject;
  late BehaviorSubject<bool> _teledartToggleSubject;

  late Stream _teledartStream;
  late String _addressString;

  late Sink _teledartToggleSink;
  late Sink _teledartSink;

  Stream? _address;

  Stream get stream => _teledartStream;

  Sink get sink => _teledartToggleSink;

  TeledartBloc(Stream? address) {
    _teledartSubject =
        BehaviorSubject.seeded(Teledart((t) => t..running = false));
    _teledartToggleSubject = BehaviorSubject();
    _teledartToggleSink = _teledartToggleSubject.sink;
    _teledartStream = _teledartSubject.stream;
    _teledartSink = _teledartSubject.sink;
    _teledartToggleSubject.listen(_teledartToggleListener);
    _address = address;
    _address?.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _teledartToggleListener(toggle) async {
    try {
      await http
          .post(Uri(path: 'http://$_addressString:8888/teledart/$toggle'));
    } catch (e) {
      // Bloc.instance.scaffold.showSnackBar(SnackBar(
      //   content: Text('${e.toString()}'),
      // ));
    }
  }

  void _update(String address) async {
    _addressString = address;
    try {
      final res =
          await http.get(Uri(path: 'http://$_addressString:8888/teledart/1'));
      _teledartSink.add(Teledart.fromJson(res.body));
    } catch (e) {
      // Bloc.instance.scaffold.showSnackBar(SnackBar(
      //   content: Text('${e.toString()}'),
      // ));
    }
  }

  void close() {
    _teledartSink.close();
    _teledartToggleSink.close();
    _teledartToggleSubject.close();
    _teledartSubject.close();
  }
}
