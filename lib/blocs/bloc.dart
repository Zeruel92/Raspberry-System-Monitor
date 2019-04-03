import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/blocs/reboot.dart';
import 'package:raspberry_system_monitor/blocs/uptime_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:raspberry_system_monitor/models/torrentstat.dart';
import 'package:raspberry_system_monitor/models/teledart.dart';

class Bloc {
  UptimeBloc uptime;
  RebootBloc reboot;

  BehaviorSubject<InternetAddress> _indirizzoRaspberrySubject;
  BehaviorSubject<TorrentStats> _torrentSubject;
  BehaviorSubject _powerOffSubject;

  BehaviorSubject _torrentToggleSubject;
  BehaviorSubject _teledartSubject;
  BehaviorSubject _teledartToggleSubject;

  Sink<InternetAddress> _sinkAddress;

  Sink _powerOffSink;

  Sink _torrentSink;
  Sink _torrentToggleSink;
  Sink _teledartToggleSink;
  Sink _teledartSink;

  Stream _torrentStream;
  Stream _teledartStream;

  Stream get torrent => _torrentStream;
  Sink get powerOff => _powerOffSink;

  Sink get torrentToggleSink => _torrentToggleSink;
  Stream get teledart => _teledartStream;
  Sink get teledartToggleSink => _teledartToggleSink;
  Stream get address => _indirizzoRaspberrySubject.stream;

  Bloc() {
    _indirizzoRaspberrySubject = new BehaviorSubject();

    uptime = UptimeBloc();
    reboot = RebootBloc(address);

    _powerOffSubject = new BehaviorSubject();

    _torrentSubject = new BehaviorSubject();
    _torrentToggleSubject = new BehaviorSubject();
    _teledartSubject = new BehaviorSubject();
    _teledartToggleSubject = new BehaviorSubject();
    _torrentToggleSink = _torrentToggleSubject.sink;
    _torrentStream = _torrentSubject.stream;
    _torrentSink = _torrentSubject.sink;

    _powerOffSink = _powerOffSubject.sink;
    _sinkAddress = _indirizzoRaspberrySubject.sink;

    _teledartToggleSink = _teledartToggleSubject.sink;
    _teledartStream = _teledartSubject.stream;
    _teledartSink = _teledartSubject.sink;
    _teledartToggleSubject.listen(_teledartToggleListener);
    _socketListen();
    _indirizzoRaspberrySubject.listen(_addressListener);
    _powerOffSubject.listen(_powerOffListener);

    _torrentToggleSubject.listen(_torrentToggleListener);
  }

  void _addressListener(address) async {
    dynamic res;

    uptime.update(address.address);

    res = await http.get('http://${address.address}:8888/torrentstatus');
    _torrentSink.add(TorrentStats.fromJson(res.body));
    res = await http.get('http://${address.address}:8888/teledart/1');
    _teledartSink.add(Teledart.fromJson(res.body));
  }

  void _powerOffListener(onValue) async {
    dynamic res = await http.get(
        'http://${_indirizzoRaspberrySubject.stream.value.address}:8888/poweroff');
    print(res.body);
  }

  void _torrentToggleListener(toggle) async {
    await http.post(
        'http://${_indirizzoRaspberrySubject.stream.value.address}:8888/torrentToggle/$toggle');
  }

  void _teledartToggleListener(toggle) async {
    await http.post(
        'http://${_indirizzoRaspberrySubject.stream.value.address}:8888/teledart/$toggle');
  }

  void close() {
    uptime.close();
    _indirizzoRaspberrySubject.close();
    _powerOffSubject.close();
    _torrentSubject.close();
    _torrentSink.close();
    _torrentToggleSink.close();
    _powerOffSink.close();
    reboot.close();
    _sinkAddress.close();
    _teledartSubject.close();
    _teledartToggleSink.close();
  }

  void _socketListen() {
    //InternetAddress address = InternetAddress('192.168.1.59');
    //_sinkAddress.add(address);
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
      socket.listen((e) {
        Datagram dg = socket.receive();
        _sinkAddress.add(dg?.address);
      });
    });
  }
}
