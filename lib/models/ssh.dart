library ssh;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'ssh.g.dart';

abstract class SSHStatus implements Built<SSHStatus, SSHStatusBuilder> {
  // fields go here
  bool get running;

  SSHStatus._();

  factory SSHStatus([updates(SSHStatusBuilder b)]) = _$SSHStatus;

  String toJson() {
    return json.encode(serializers.serializeWith(SSHStatus.serializer, this));
  }

  static SSHStatus fromJson(String jsonString) {
    return serializers.deserializeWith(
        SSHStatus.serializer, json.decode(jsonString));
  }

  static Serializer<SSHStatus> get serializer => _$sSHStatusSerializer;
}
