import 'package:http/http.dart' as http;
import 'package:raspberry_system_monitor/models/disk.dart';
import 'package:rxdart/rxdart.dart';

class DiskBloc {
  BehaviorSubject<DiskModel> _diskSubject;
  Sink _sinkDisk;

  Stream _diskStream;
  Stream _address;
  Stream get stream => _diskStream;

  DiskBloc(Stream address) {
    _diskSubject = new BehaviorSubject();
    _sinkDisk = _diskSubject.sink;
    _diskStream = _diskSubject.stream;
    _address = address;
    _address.listen((address) {
      if (address != null) _update(address.address);
    });
  }

  void _update(String address) async {
    try{
      final res = await http.get('http://$address:8888/uptime');
      _sinkDisk.add(DiskModel.fromJson(res.body));
    }catch (e){}
  }

  void close() {
    _diskSubject.close();
    _sinkDisk.close();
  }
}