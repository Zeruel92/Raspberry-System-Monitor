import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/teledart.dart';

class TeledartBloc {
  BehaviorSubject<Teledart> _teledartSubject;
  BehaviorSubject _teledartToggleSubject;

  Stream _teledartStream;
  String _addressString;

  Sink _teledartToggleSink;
  Sink _teledartSink;

  Stream get stream => _teledartStream;
  Sink get sink => _teledartToggleSink;

  TeledartBloc() {
    _teledartSubject = new BehaviorSubject();
    _teledartToggleSubject = new BehaviorSubject();
    _teledartToggleSink = _teledartToggleSubject.sink;
    _teledartStream = _teledartSubject.stream;
    _teledartSink = _teledartSubject.sink;
    _teledartToggleSubject.listen(_teledartToggleListener);
    _addressString = '';
  }

  void _teledartToggleListener(toggle) async {
    await http.post('http://$_addressString:8888/teledart/$toggle');
  }

  void update(String address) async {
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
