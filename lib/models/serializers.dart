library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'uptime.dart';
import 'torrentstat.dart';
import 'teledart.dart';
import 'samba.dart';
part 'serializers.g.dart';

@SerializersFor(const [Uptime, TorrentStats, Teledart, Samba])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
