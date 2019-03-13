library uptime;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'uptime.g.dart';

abstract class Uptime implements Built<Uptime, UptimeBuilder> {
  // fields go here
  String get uptime;

  Uptime._();

  factory Uptime([updates(UptimeBuilder b)]) = _$Uptime;

  String toJson() {
    return json.encode(serializers.serializeWith(Uptime.serializer, this));
  }

  static Uptime fromJson(String jsonString) {
    return serializers.deserializeWith(
        Uptime.serializer, json.decode(jsonString));
  }

  static Serializer<Uptime> get serializer => _$uptimeSerializer;
}
