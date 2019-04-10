library ssh;

import 'dart:convert';

import 'package:build_daemon/data/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ssh.g.dart';

abstract class SSH implements Built<SSH, SSHBuilder> {
  // fields go here
  bool get running;

  SSH._();

  factory SSH([updates(SSHBuilder b)]) = _$SSH;

  String toJson() {
    return json.encode(serializers.serializeWith(SSH.serializer, this));
  }

  static SSH fromJson(String jsonString) {
    return serializers.deserializeWith(SSH.serializer, json.decode(jsonString));
  }

  static Serializer<SSH> get serializer => _$sSHSerializer;
}
