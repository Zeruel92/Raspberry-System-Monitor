import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class PoweroffBloc {
  BehaviorSubject _powerOffSubject;
  Sink _powerOffSink;
  Sink get sink => _powerOffSink;
  Stream _address;

  PoweroffBloc(Stream address) {
    _powerOffSubject = new BehaviorSubject();
    _powerOffSink = _powerOffSubject.sink;
    _powerOffSubject.listen(_powerOffListener);
  }

  void _powerOffListener(onValue) async {
    dynamic res = await http.get('http://${_address.last}:8888/poweroff');
    print(res.body);
  }

  void close() {
    _powerOffSubject.close();
    _powerOffSink.close();
  }
}
