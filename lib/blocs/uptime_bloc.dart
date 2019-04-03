import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/uptime.dart';

class UptimeBloc {
  BehaviorSubject<Uptime> _uptimeSubject;
  Stream _uptimeStream;
  Stream get stream => _uptimeStream;
  Sink _sinkUptime;

  UptimeBloc() {
    _uptimeSubject = new BehaviorSubject();
    _sinkUptime = _uptimeSubject.sink;
    _uptimeStream = _uptimeSubject.stream;
  }

  void update(String address) async {
    dynamic res = await http.get('http://$address:8888/uptime');
    _sinkUptime.add(Uptime.fromJson(res.body));
  }

  void close() {
    _uptimeSubject.close();
  }
}
