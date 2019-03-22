library torrentstat;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:raspberry_system_monitor/models/serializers.dart';

part 'torrentstat.g.dart';

abstract class TorrentStats
    implements Built<TorrentStats, TorrentStatsBuilder> {
  // fields go here
  String get torrentStatus;

  TorrentStats._();

  factory TorrentStats([updates(TorrentStatsBuilder b)]) = _$TorrentStats;

  String toJson() {
    return json
        .encode(serializers.serializeWith(TorrentStats.serializer, this));
  }

  static TorrentStats fromJson(String jsonString) {
    return serializers.deserializeWith(
        TorrentStats.serializer, json.decode(jsonString));
  }

  static Serializer<TorrentStats> get serializer => _$torrentStatsSerializer;
}
