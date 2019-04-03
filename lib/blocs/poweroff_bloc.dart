import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class PoweroffBloc {
  BehaviorSubject _powerOffSubject;
  Sink _powerOffSink;
  Stream _address;
  Sink get sink => _powerOffSink;

  String _addressString;

  PoweroffBloc(Stream address) {
    _powerOffSubject = new BehaviorSubject();
    _powerOffSink = _powerOffSubject.sink;
    _powerOffSubject.listen(_powerOffListener);
    _address = address;
    _address.listen((address) => _update(address.address));
  }

  void _powerOffListener(onValue) async {
    dynamic res = await http.get('http://$_addressString:8888/poweroff');
    print(res.body);
  }

  void _update(String address) {
    _addressString = address;
  }

  void close() {
    _powerOffSubject.close();
    _powerOffSink.close();
  }
}
