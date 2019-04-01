library teledart;

import 'dart:convert';

import 'serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teledart.g.dart';

abstract class Teledart implements Built<Teledart, TeledartBuilder> {
  // fields go here
  bool get running;

  Teledart._();

  factory Teledart([updates(TeledartBuilder b)]) = _$Teledart;

  String toJson() {
    return json.encode(serializers.serializeWith(Teledart.serializer, this));
  }

  static Teledart fromJson(String jsonString) {
    return serializers.deserializeWith(
        Teledart.serializer, json.decode(jsonString));
  }

  static Serializer<Teledart> get serializer => _$teledartSerializer;
}
