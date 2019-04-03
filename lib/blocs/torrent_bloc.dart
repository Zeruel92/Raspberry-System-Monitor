import 'package:raspberry_system_monitor/models/torrentstat.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class TorrentBloc {
  BehaviorSubject<TorrentStats> _torrentSubject;
  BehaviorSubject _torrentToggleSubject;

  Sink _torrentSink;
  Sink _torrentToggleSink;

  Stream _torrentStream;
  Stream _address;

  String _addressString;

  Stream get stream => _torrentStream;
  Sink get sink => _torrentToggleSink;

  TorrentBloc(Stream address) {
    _torrentSubject = new BehaviorSubject();
    _torrentToggleSubject = new BehaviorSubject();
    _torrentToggleSink = _torrentToggleSubject.sink;
    _torrentStream = _torrentSubject.stream;
    _torrentSink = _torrentSubject.sink;
    _torrentToggleSubject.listen(_torrentToggleListener);
    _address = address;
    _address.listen((address) => _update(address.address));
  }

  void _update(String address) async {
    _addressString = address;
    final res = await http.get('http://$_addressString:8888/torrentstatus');
    _torrentSink.add(TorrentStats.fromJson(res.body));
  }

  void _torrentToggleListener(toggle) async {
    await http.post('http://$_addressString:8888/torrentToggle/$toggle');
  }

  void close() {
    _torrentSubject.close();
    _torrentSink.close();
    _torrentToggleSink.close();
  }
}
