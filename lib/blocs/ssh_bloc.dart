import 'package:rxdart/rxdart.dart';

class SSHBloc {
  BehaviorSubject _subject;
  BehaviorSubject _toggleSubject;

  Stream _stream;
  String _addressString;

  Sink _tSink;
  Sink _sshSink;

  Stream _address;

  Stream get stream => _stream;
  Sink get sink => _tSink;

  SSHBloc(Stream address) {}

  void close() {}
}
