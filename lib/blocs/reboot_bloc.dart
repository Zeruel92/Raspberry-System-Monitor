import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class RebootBloc {
  BehaviorSubject _rebootSubject;
  Sink _rebootSink;

  String _addressString;

  Sink get sink => _rebootSink;
  Stream _address;

  RebootBloc(Stream address) {
    _rebootSubject = new BehaviorSubject();
    _rebootSink = _rebootSubject.sink;
    _rebootSubject.listen(_rebootListener);
    _address = address;
    _address.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _update(String address) {
    _addressString = address;
  }

  void _rebootListener(onValue) async {
    try{
      final res = await http.get('http://$_addressString:8888/reboot');
      Bloc.instance.scaffold.showSnackBar(
          SnackBar(content: Text('${res.body}')));
    } catch (e) {
      Bloc.instance.scaffold.showSnackBar(
          SnackBar(content: Text('${e.toString()}'),));
    }
  }

  void close() {
    _rebootSubject.close();
    _rebootSink.close();
  }
}
