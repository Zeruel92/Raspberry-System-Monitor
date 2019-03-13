import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class Bloc {
  BehaviorSubject<String> _uptimeSubject;
  BehaviorSubject<InternetAddress> _indirizzoRaspberrySubject;

  Sink<InternetAddress> _sinkAddress;
  Sink _sinkUptime;
  Stream _uptimeStream;

  Stream get uptime => _uptimeStream;

  Bloc() {
    _uptimeSubject = new BehaviorSubject();
    _indirizzoRaspberrySubject = new BehaviorSubject();
    _sinkAddress = _indirizzoRaspberrySubject.sink;
    _sinkUptime = _uptimeSubject.sink;
    _uptimeStream = _uptimeSubject.stream;
    _socketListen();
    _indirizzoRaspberrySubject.listen((address) async {
      dynamic res = await http.get('http://${address.address}:8888/uptime');
      _sinkUptime.add(res.body);
    });
  }

  void close() {
    _uptimeSubject.close();
    _indirizzoRaspberrySubject.close();
    _sinkAddress.close();
    _sinkUptime.close();
  }

  void _socketListen() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
      socket.listen((e) {
        Datagram dg = socket.receive();
        _sinkAddress.add(dg.address);
      });
    });
  }
}
