library apfs;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:raspberry_system_monitor/models/serializers.dart';

part 'apfs.g.dart';

abstract class NetAtalk implements Built<NetAtalk, NetAtalkBuilder> {
  // fields go here
  bool? get running;

  NetAtalk._();

  factory NetAtalk([updates(NetAtalkBuilder b)]) = _$NetAtalk;

  String toJson() {
    return json.encode(serializers.serializeWith(NetAtalk.serializer, this));
  }

  static NetAtalk fromJson(String jsonString) {
    return serializers.deserializeWith(
        NetAtalk.serializer, json.decode(jsonString));
  }

  static Serializer<NetAtalk> get serializer => _$netAtalkSerializer;
}
