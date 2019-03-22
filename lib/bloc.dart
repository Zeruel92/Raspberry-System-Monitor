import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'models/uptime.dart';

class Bloc {
  BehaviorSubject<Uptime> _uptimeSubject;
  BehaviorSubject<InternetAddress> _indirizzoRaspberrySubject;
  BehaviorSubject _powerOffSubject;
  BehaviorSubject _rebootSubject;

  Sink<InternetAddress> _sinkAddress;
  Sink _sinkUptime;
  Sink _powerOffSink;
  Sink _rebootSink;

  Stream _uptimeStream;

  Stream get uptime => _uptimeStream;
  Sink get powerOff => _powerOffSink;
  Sink get reboot => _rebootSink;

  Bloc() {
    _uptimeSubject = new BehaviorSubject();
    _indirizzoRaspberrySubject = new BehaviorSubject();
    _powerOffSubject = new BehaviorSubject();
    _rebootSubject = new BehaviorSubject();
    _rebootSink = _rebootSubject.sink;
    _powerOffSink = _powerOffSubject.sink;
    _sinkAddress = _indirizzoRaspberrySubject.sink;
    _sinkUptime = _uptimeSubject.sink;
    _uptimeStream = _uptimeSubject.stream;
    _socketListen();
    _indirizzoRaspberrySubject.listen(_addressListener);
    _powerOffSubject.listen(_powerOffListener);
    _rebootSubject.listen(_rebootListener);
  }

  void _addressListener(address) async {
    dynamic res = await http.get('http://${address.address}:8888/uptime');
    _sinkUptime.add(Uptime.fromJson(res.body));
  }

  void _powerOffListener(onValue) async {
    dynamic res = await http.get(
        'http://${_indirizzoRaspberrySubject.stream.value.address}:8888/poweroff');
    print(res.body);
  }

  void _rebootListener(onValue) async {
    dynamic res = await http.get(
        'http://${_indirizzoRaspberrySubject.stream.value.address}:8888/reboot');
    print(res.body);
  }

  void close() {
    _uptimeSubject.close();
    _indirizzoRaspberrySubject.close();
    _powerOffSubject.close();
    _powerOffSink.close();
    _rebootSubject.close();
    _rebootSink.close();
    _sinkAddress.close();
    _sinkUptime.close();
  }

  void _socketListen() {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
      socket.listen((e) {
        Datagram dg = socket.receive();
        _sinkAddress.add(dg?.address);
      });
    });
  }
}
