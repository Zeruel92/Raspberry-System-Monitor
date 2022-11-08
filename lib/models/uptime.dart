library uptime;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'uptime.g.dart';

abstract class Uptime implements Built<Uptime, UptimeBuilder> {
  String get time;
  double get loadAvg;
  double get loadAvg5;
  double get loadAvg15;
  double get temp;

  Uptime._();

  factory Uptime([updates(UptimeBuilder b)]) = _$Uptime;

  String toJson() {
    return json.encode(serializers.serializeWith(Uptime.serializer, this));
  }

  static Uptime? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Uptime.serializer, json.decode(jsonString));
  }

  static Serializer<Uptime> get serializer => _$uptimeSerializer;
}
