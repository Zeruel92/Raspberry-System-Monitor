// GENERATED CODE - DO NOT MODIFY BY HAND

part of torrentstat;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TorrentStats> _$torrentStatsSerializer =
    new _$TorrentStatsSerializer();

class _$TorrentStatsSerializer implements StructuredSerializer<TorrentStats> {
  @override
  final Iterable<Type> types = const [TorrentStats, _$TorrentStats];
  @override
  final String wireName = 'TorrentStats';

  @override
  Iterable serialize(Serializers serializers, TorrentStats object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'torrentStatus',
      serializers.serialize(object.torrentStatus,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TorrentStats deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TorrentStatsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'torrentStatus':
          result.torrentStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TorrentStats extends TorrentStats {
  @override
  final String torrentStatus;

  factory _$TorrentStats([void updates(TorrentStatsBuilder b)]) =>
      (new TorrentStatsBuilder()..update(updates)).build();

  _$TorrentStats._({this.torrentStatus}) : super._() {
    if (torrentStatus == null) {
      throw new BuiltValueNullFieldError('TorrentStats', 'torrentStatus');
    }
  }

  @override
  TorrentStats rebuild(void updates(TorrentStatsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TorrentStatsBuilder toBuilder() => new TorrentStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TorrentStats && torrentStatus == other.torrentStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(0, torrentStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TorrentStats')
          ..add('torrentStatus', torrentStatus))
        .toString();
  }
}

class TorrentStatsBuilder
    implements Builder<TorrentStats, TorrentStatsBuilder> {
  _$TorrentStats _$v;

  String _torrentStatus;
  String get torrentStatus => _$this._torrentStatus;
  set torrentStatus(String torrentStatus) =>
      _$this._torrentStatus = torrentStatus;

  TorrentStatsBuilder();

  TorrentStatsBuilder get _$this {
    if (_$v != null) {
      _torrentStatus = _$v.torrentStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TorrentStats other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TorrentStats;
  }

  @override
  void update(void updates(TorrentStatsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TorrentStats build() {
    final _$result = _$v ?? new _$TorrentStats._(torrentStatus: torrentStatus);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new