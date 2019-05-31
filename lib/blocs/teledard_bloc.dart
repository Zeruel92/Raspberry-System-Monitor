import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/teledart.dart';
import 'package:rxdart/rxdart.dart';

class TeledartBloc {
  BehaviorSubject<Teledart> _teledartSubject;
  BehaviorSubject<bool> _teledartToggleSubject;

  Stream _teledartStream;
  String _addressString;

  Sink _teledartToggleSink;
  Sink _teledartSink;

  Stream _address;

  Stream get stream => _teledartStream;
  Sink get sink => _teledartToggleSink;

  TeledartBloc(Stream address) {
    _teledartSubject =
        new BehaviorSubject.seeded(Teledart((t) => t..running = false));
    _teledartToggleSubject = new BehaviorSubject();
    _teledartToggleSink = _teledartToggleSubject.sink;
    _teledartStream = _teledartSubject.stream;
    _teledartSink = _teledartSubject.sink;
    _teledartToggleSubject.listen(_teledartToggleListener);
    _address = address;
    _address.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _teledartToggleListener(toggle) async {
    await http.post('http://$_addressString:8888/teledart/$toggle');
  }

  void _update(String address) async {
    _addressString = address;
    final res = await http.get('http://$_addressString:8888/teledart/1');
    _teledartSink.add(Teledart.fromJson(res.body));
  }

  void close() {
    _teledartSink.close();
    _teledartToggleSink.close();
    _teledartToggleSubject.close();
    _teledartSubject.close();
  }
}
