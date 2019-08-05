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
  Iterable<Object> serialize(Serializers serializers, Uptime object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'time',
      serializers.serialize(object.time, specifiedType: const FullType(String)),
      'loadAvg',
      serializers.serialize(object.loadAvg,
          specifiedType: const FullType(double)),
      'loadAvg5',
      serializers.serialize(object.loadAvg5,
          specifiedType: const FullType(double)),
      'loadAvg15',
      serializers.serialize(object.loadAvg15,
          specifiedType: const FullType(double)),
      'temp',
      serializers.serialize(object.temp, specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  Uptime deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UptimeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'time':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'loadAvg':
          result.loadAvg = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'loadAvg5':
          result.loadAvg5 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'loadAvg15':
          result.loadAvg15 = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'temp':
          result.temp = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Uptime extends Uptime {
  @override
  final String time;
  @override
  final double loadAvg;
  @override
  final double loadAvg5;
  @override
  final double loadAvg15;
  @override
  final double temp;

  factory _$Uptime([void Function(UptimeBuilder) updates]) =>
      (new UptimeBuilder()..update(updates)).build();

  _$Uptime._(
      {this.time, this.loadAvg, this.loadAvg5, this.loadAvg15, this.temp})
      : super._() {
    if (time == null) {
      throw new BuiltValueNullFieldError('Uptime', 'time');
    }
    if (loadAvg == null) {
      throw new BuiltValueNullFieldError('Uptime', 'loadAvg');
    }
    if (loadAvg5 == null) {
      throw new BuiltValueNullFieldError('Uptime', 'loadAvg5');
    }
    if (loadAvg15 == null) {
      throw new BuiltValueNullFieldError('Uptime', 'loadAvg15');
    }
    if (temp == null) {
      throw new BuiltValueNullFieldError('Uptime', 'temp');
    }
  }

  @override
  Uptime rebuild(void Function(UptimeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UptimeBuilder toBuilder() => new UptimeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Uptime &&
        time == other.time &&
        loadAvg == other.loadAvg &&
        loadAvg5 == other.loadAvg5 &&
        loadAvg15 == other.loadAvg15 &&
        temp == other.temp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, time.hashCode), loadAvg.hashCode),
                loadAvg5.hashCode),
            loadAvg15.hashCode),
        temp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Uptime')
          ..add('time', time)
          ..add('loadAvg', loadAvg)
          ..add('loadAvg5', loadAvg5)
          ..add('loadAvg15', loadAvg15)
          ..add('temp', temp))
        .toString();
  }
}

class UptimeBuilder implements Builder<Uptime, UptimeBuilder> {
  _$Uptime _$v;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  double _loadAvg;
  double get loadAvg => _$this._loadAvg;
  set loadAvg(double loadAvg) => _$this._loadAvg = loadAvg;

  double _loadAvg5;
  double get loadAvg5 => _$this._loadAvg5;
  set loadAvg5(double loadAvg5) => _$this._loadAvg5 = loadAvg5;

  double _loadAvg15;
  double get loadAvg15 => _$this._loadAvg15;
  set loadAvg15(double loadAvg15) => _$this._loadAvg15 = loadAvg15;

  double _temp;
  double get temp => _$this._temp;
  set temp(double temp) => _$this._temp = temp;

  UptimeBuilder();

  UptimeBuilder get _$this {
    if (_$v != null) {
      _time = _$v.time;
      _loadAvg = _$v.loadAvg;
      _loadAvg5 = _$v.loadAvg5;
      _loadAvg15 = _$v.loadAvg15;
      _temp = _$v.temp;
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
  void update(void Function(UptimeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Uptime build() {
    final _$result = _$v ??
        new _$Uptime._(
            time: time,
            loadAvg: loadAvg,
            loadAvg5: loadAvg5,
            loadAvg15: loadAvg15,
            temp: temp);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
