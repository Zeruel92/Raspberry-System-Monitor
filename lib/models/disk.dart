library disk;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:raspberry_system_monitor/models/serializers.dart';

part 'disk.g.dart';

abstract class DiskModel implements Built<DiskModel,DiskModelBuilder>{
  String get df;

  DiskModel._();

  factory DiskModel([updates(DiskModelBuilder b)]) = _$DiskModel;

  String toJson() {
    return json.encode(serializers.serializeWith(DiskModel.serializer, this));
  }

  static DiskModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        DiskModel.serializer, json.decode(jsonString));
  }

  static Serializer<DiskModel> get serializer => _$diskModelSerializer;
}