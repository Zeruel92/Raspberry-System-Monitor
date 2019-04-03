import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class RebootBloc {
  BehaviorSubject _rebootSubject;
  Sink _rebootSink;
  Sink get sink => _rebootSink;
  String _addressString;

  RebootBloc() {
    _rebootSubject = new BehaviorSubject();
    _rebootSink = _rebootSubject.sink;
    _rebootSubject.listen(_rebootListener);
    _addressString = '';
  }

  void update(String address) {
    _addressString = address;
  }

  void _rebootListener(onValue) async {
    dynamic res = await http.get('http://$_addressString:8888/reboot');
    print(res.body);
  }

  void close() {
    _rebootSubject.close();
    _rebootSink.close();
  }
}
