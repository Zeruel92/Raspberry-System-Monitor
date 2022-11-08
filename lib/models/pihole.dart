library pihole;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'pihole.g.dart';

abstract class Pihole implements Built<Pihole, PiholeBuilder> {
  // fields go here
  bool get running;

  Pihole._();

  factory Pihole([updates(PiholeBuilder b)]) = _$Pihole;

  String toJson() {
    return json.encode(serializers.serializeWith(Pihole.serializer, this));
  }

  static Pihole? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Pihole.serializer, json.decode(jsonString));
  }

  static Serializer<Pihole> get serializer => _$piholeSerializer;
}
