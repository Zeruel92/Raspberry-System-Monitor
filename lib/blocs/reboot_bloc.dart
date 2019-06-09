import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class RebootBloc {
  BehaviorSubject _rebootSubject;
  Sink _rebootSink;

  String _addressString;
  Sink get sink => _rebootSink;
  Stream _address;

  RebootBloc(Stream address) {
    _rebootSubject = new BehaviorSubject();
    _rebootSink = _rebootSubject.sink;
    _rebootSubject.listen(_rebootListener);
    _address = address;
    _address.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _update(String address) {
    _addressString = address;
  }

  void _rebootListener(onValue) async {
    try{
      final res = await http.get('http://$_addressString:8888/reboot');
      print(res.body);
    }catch(e){}
  }

  void close() {
    _rebootSubject.close();
    _rebootSink.close();
  }
}
