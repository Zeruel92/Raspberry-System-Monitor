// GENERATED CODE - DO NOT MODIFY BY HAND

part of uptime;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Uptime> _$uptimeSerializer = new _$UptimeSerializer();

class _$UptimeSerializer implements StructuredSerializer<Uptime> {
  @override
  final Iterable<Type> types = const [Uptime, _$Uptime];
  @override
  final String wireName = 'Uptime';

  @override
  Iterable serialize(Serializers serializers, Uptime object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'uptime',
      serializers.serialize(object.uptime,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Uptime deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UptimeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'uptime':
          result.uptime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Uptime extends Uptime {
  @override
  final String uptime;

  factory _$Uptime([void updates(UptimeBuilder b)]) =>
      (new UptimeBuilder()..update(updates)).build();

  _$Uptime._({this.uptime}) : super._() {
    if (uptime == null) {
      throw new BuiltValueNullFieldError('Uptime', 'uptime');
    }
  }

  @override
  Uptime rebuild(void updates(UptimeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UptimeBuilder toBuilder() => new UptimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Uptime && uptime == other.uptime;
  }

  @override
  int get hashCode {
    return $jf($jc(0, uptime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Uptime')..add('uptime', uptime))
        .toString();
  }
}

class UptimeBuilder implements Builder<Uptime, UptimeBuilder> {
  _$Uptime _$v;

  String _uptime;
  String get uptime => _$this._uptime;
  set uptime(String uptime) => _$this._uptime = uptime;

  UptimeBuilder();

  UptimeBuilder get _$this {
    if (_$v != null) {
      _uptime = _$v.uptime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Uptime other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Uptime;
  }

  @override
  void update(void updates(UptimeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Uptime build() {
    final _$result = _$v ?? new _$Uptime._(uptime: uptime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
