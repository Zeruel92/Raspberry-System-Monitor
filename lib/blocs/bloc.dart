import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:raspberry_system_monitor/blocs/apfs_bloc.dart';
import 'package:raspberry_system_monitor/blocs/poweroff_bloc.dart';
import 'package:raspberry_system_monitor/blocs/reboot_bloc.dart';
import 'package:raspberry_system_monitor/blocs/samba_bloc.dart';
import 'package:raspberry_system_monitor/blocs/ssh_bloc.dart';
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
  SambaBloc samba;
  SSHBloc ssh;
  NetAtalkBloc apfs;

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
    samba = SambaBloc(address);
    ssh = SSHBloc(address);
    apfs = NetAtalkBloc(address);
    _sinkAddress = _indirizzoRaspberrySubject.sink;
    _socketListen();
  }

  void close() {
    uptime.close();
    poweroff.close();
    reboot.close();
    teledart.close();
    torrent.close();
    samba.close();
    ssh.close();
    _indirizzoRaspberrySubject.close();
    _sinkAddress.close();
  }

  void _socketListen() {
    //Run only if debug [import 'package:flutter/foundation.dart'; for kReleaseMode]
    if (!kReleaseMode) {
      Timer.periodic(Duration(seconds: 10), (_) {
        _sinkAddress.add(InternetAddress('192.168.1.59'));
      });
    }
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
      socket.listen((e) {
        Datagram dg = socket.receive();
        _sinkAddress.add(dg?.address);
      });
    });
  }
}
