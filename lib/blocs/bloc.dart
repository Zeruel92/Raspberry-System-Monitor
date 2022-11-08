import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/apfs_bloc.dart';
import 'package:raspberry_system_monitor/blocs/disk_bloc.dart';
import 'package:raspberry_system_monitor/blocs/pihole_bloc.dart';
import 'package:raspberry_system_monitor/blocs/poweroff_bloc.dart';
import 'package:raspberry_system_monitor/blocs/reboot_bloc.dart';
import 'package:raspberry_system_monitor/blocs/samba_bloc.dart';
import 'package:raspberry_system_monitor/blocs/ssh_bloc.dart';
import 'package:raspberry_system_monitor/blocs/teledard_bloc.dart';
import 'package:raspberry_system_monitor/blocs/theme_bloc.dart';
import 'package:raspberry_system_monitor/blocs/torrent_bloc.dart';
import 'package:raspberry_system_monitor/blocs/uptime_bloc.dart';
import 'package:rxdart/rxdart.dart';

class Bloc {
  static final Bloc _instance = Bloc._private();

  static Bloc get instance => _instance;

  late UptimeBloc uptime;
  late RebootBloc reboot;
  late PoweroffBloc poweroff;
  late TeledartBloc teledart;
  late TorrentBloc torrent;
  late SambaBloc samba;
  late SSHBloc ssh;
  late NetAtalkBloc apfs;
  late DiskBloc disk;
  late PiholeBloc pihole;
  late ThemeBloc theme;

  late BehaviorSubject _indirizzoRaspberrySubject;

  late Sink _sinkAddress;

  Stream get address => _indirizzoRaspberrySubject.stream;

  late GlobalKey<ScaffoldState> _scaffoldState;

  void setScaffoldState(GlobalKey<ScaffoldState> scaffoldState) =>
      _scaffoldState = scaffoldState;

  ScaffoldState? get scaffold => _scaffoldState.currentState;

  Bloc._private() {
    _indirizzoRaspberrySubject = new BehaviorSubject();
    uptime = UptimeBloc(address);
    reboot = RebootBloc(address);
    poweroff = PoweroffBloc(address);
    teledart = TeledartBloc(address);
    torrent = TorrentBloc(address);
    samba = SambaBloc(address);
    ssh = SSHBloc(address);
    apfs = NetAtalkBloc(address);
    disk = DiskBloc(address);
    pihole = PiholeBloc(address);
    theme = ThemeBloc();
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
    disk.close();
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
        Datagram? dg = socket.receive();
        _sinkAddress.add(dg?.address);
      });
    });
  }
}
