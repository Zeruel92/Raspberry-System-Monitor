library samba;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';

part 'samba.g.dart';

abstract class Samba implements Built<Samba, SambaBuilder> {
  // fields go here
  bool get running;

  Samba._();

  factory Samba([updates(SambaBuilder b)]) = _$Samba;

  String toJson() {
    return json.encode(serializers.serializeWith(Samba.serializer, this));
  }

  static Samba fromJson(String jsonString) {
    return serializers.deserializeWith(
        Samba.serializer, json.decode(jsonString));
  }

  static Serializer<Samba> get serializer => _$sambaSerializer;
}
