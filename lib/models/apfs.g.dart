// GENERATED CODE - DO NOT MODIFY BY HAND

part of apfs;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NetAtalk> _$netAtalkSerializer = new _$NetAtalkSerializer();

class _$NetAtalkSerializer implements StructuredSerializer<NetAtalk> {
  @override
  final Iterable<Type> types = const [NetAtalk, _$NetAtalk];
  @override
  final String wireName = 'NetAtalk';

  @override
  Iterable serialize(Serializers serializers, NetAtalk object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'running',
      serializers.serialize(object.running,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  NetAtalk deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NetAtalkBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'running':
          result.running = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$NetAtalk extends NetAtalk {
  @override
  final bool running;

  factory _$NetAtalk([void updates(NetAtalkBuilder b)]) =>
      (new NetAtalkBuilder()..update(updates)).build();

  _$NetAtalk._({this.running}) : super._() {
    if (running == null) {
      throw new BuiltValueNullFieldError('NetAtalk', 'running');
    }
  }

  @override
  NetAtalk rebuild(void updates(NetAtalkBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  NetAtalkBuilder toBuilder() => new NetAtalkBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetAtalk && running == other.running;
  }

  @override
  int get hashCode {
    return $jf($jc(0, running.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NetAtalk')..add('running', running))
        .toString();
  }
}

class NetAtalkBuilder implements Builder<NetAtalk, NetAtalkBuilder> {
  _$NetAtalk _$v;

  bool _running;
  bool get running => _$this._running;
  set running(bool running) => _$this._running = running;

  NetAtalkBuilder();

  NetAtalkBuilder get _$this {
    if (_$v != null) {
      _running = _$v.running;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetAtalk other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NetAtalk;
  }

  @override
  void update(void updates(NetAtalkBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$NetAtalk build() {
    final _$result = _$v ?? new _$NetAtalk._(running: running);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
