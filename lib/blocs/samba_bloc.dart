import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/samba.dart';
import 'package:rxdart/rxdart.dart';

class SambaBloc {
  BehaviorSubject<Samba> _subject;
  BehaviorSubject<bool> _toggleSubject;

  Stream _stream;
  String _addressString;

  Sink _tSink;
  Sink _sambaSink;

  Stream _address;

  Stream get stream => _stream;
  Sink get sink => _tSink;

  SambaBloc(Stream address) {
    _subject =
        new BehaviorSubject.seeded(Samba((samba) => samba..running = false));
    _toggleSubject = new BehaviorSubject();
    _tSink = _toggleSubject.sink;
    _stream = _subject.stream;
    _sambaSink = _subject.sink;
    _toggleSubject.listen(_sambaToggleListener);
    _address = address;
    _address.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _sambaToggleListener(toggle) async {
    await http.post('http://$_addressString:8888/smb/$toggle');
  }

  void _update(String address) async {
    _addressString = address;
    final res = await http.get('http://$_addressString:8888/smb/1');
    _sambaSink.add(Samba.fromJson(res.body));
  }

  void close() {
    _tSink.close();
    _sambaSink.close();
    _toggleSubject.close();
    _subject.close();
  }
}
