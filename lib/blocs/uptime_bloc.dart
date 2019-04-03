import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/uptime.dart';

class UptimeBloc {
  BehaviorSubject<Uptime> _uptimeSubject;

  Sink _sinkUptime;

  Stream _uptimeStream;
  Stream _address;

  Stream get stream => _uptimeStream;

  UptimeBloc(Stream address) {
    _uptimeSubject = new BehaviorSubject();
    _sinkUptime = _uptimeSubject.sink;
    _uptimeStream = _uptimeSubject.stream;
    _address = address;
  }

  void update(String address) async {
    dynamic res = await http.get('http://${_address.last}:8888/uptime');
    _sinkUptime.add(Uptime.fromJson(res.body));
  }

  void close() {
    _uptimeSubject.close();
  }
}
