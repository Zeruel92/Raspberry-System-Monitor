// GENERATED CODE - DO NOT MODIFY BY HAND

part of ssh;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SSHStatus> _$sSHStatusSerializer = new _$SSHStatusSerializer();

class _$SSHStatusSerializer implements StructuredSerializer<SSHStatus> {
  @override
  final Iterable<Type> types = const [SSHStatus, _$SSHStatus];
  @override
  final String wireName = 'SSHStatus';

  @override
  Iterable serialize(Serializers serializers, SSHStatus object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'running',
      serializers.serialize(object.running,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  SSHStatus deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SSHStatusBuilder();

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

class _$SSHStatus extends SSHStatus {
  @override
  final bool running;

  factory _$SSHStatus([void updates(SSHStatusBuilder b)]) =>
      (new SSHStatusBuilder()..update(updates)).build();

  _$SSHStatus._({this.running}) : super._() {
    if (running == null) {
      throw new BuiltValueNullFieldError('SSHStatus', 'running');
    }
  }

  @override
  SSHStatus rebuild(void updates(SSHStatusBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SSHStatusBuilder toBuilder() => new SSHStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SSHStatus && running == other.running;
  }

  @override
  int get hashCode {
    return $jf($jc(0, running.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SSHStatus')..add('running', running))
        .toString();
  }
}

class SSHStatusBuilder implements Builder<SSHStatus, SSHStatusBuilder> {
  _$SSHStatus _$v;

  bool _running;
  bool get running => _$this._running;
  set running(bool running) => _$this._running = running;

  SSHStatusBuilder();

  SSHStatusBuilder get _$this {
    if (_$v != null) {
      _running = _$v.running;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SSHStatus other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SSHStatus;
  }

  @override
  void update(void updates(SSHStatusBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SSHStatus build() {
    final _$result = _$v ?? new _$SSHStatus._(running: running);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
