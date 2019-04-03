import 'dart:async';
import 'dart:io';

import 'package:raspberry_system_monitor/blocs/poweroff_bloc.dart';
import 'package:raspberry_system_monitor/blocs/reboot_bloc.dart';
import 'package:raspberry_system_monitor/blocs/teledard_bloc.dart';
import 'package:raspberry_system_monitor/blocs/torrent_bloc.dart';
import 'package:raspberry_system_monitor/blocs/uptime_bloc.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  UptimeBloc uptime;
  RebootBloc reboot;
  PoweroffBloc poweroff;
  TeledartBloc teledart;
  TorrentBloc torrent;

  BehaviorSubject _indirizzoRaspberrySubject;

  Sink _sinkAddress;

  Stream get address => _indirizzoRaspberrySubject.stream;

  Bloc() {
    _indirizzoRaspberrySubject = new BehaviorSubject();
    uptime = UptimeBloc(address);
    reboot = RebootBloc(address);
    poweroff = PoweroffBloc(address);
    teledart = TeledartBloc(address);
    torrent = TorrentBloc(address);
    _sinkAddress = _indirizzoRaspberrySubject.sink;
    _socketListen();
  }

  void close() {
    uptime.close();
    poweroff.close();
    reboot.close();
    teledart.close();
    torrent.close();
    _indirizzoRaspberrySubject.close();
    _sinkAddress.close();
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
