// GENERATED CODE - DO NOT MODIFY BY HAND

part of ssh;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SSH> _$sSHSerializer = new _$SSHSerializer();

class _$SSHSerializer implements StructuredSerializer<SSH> {
  @override
  final Iterable<Type> types = const [SSH, _$SSH];
  @override
  final String wireName = 'SSH';

  @override
  Iterable serialize(Serializers serializers, SSH object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'running',
      serializers.serialize(object.running,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  SSH deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SSHBuilder();

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

class _$SSH extends SSH {
  @override
  final bool running;

  factory _$SSH([void updates(SSHBuilder b)]) =>
      (new SSHBuilder()..update(updates)).build();

  _$SSH._({this.running}) : super._() {
    if (running == null) {
      throw new BuiltValueNullFieldError('SSH', 'running');
    }
  }

  @override
  SSH rebuild(void updates(SSHBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SSHBuilder toBuilder() => new SSHBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SSH && running == other.running;
  }

  @override
  int get hashCode {
    return $jf($jc(0, running.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SSH')..add('running', running))
        .toString();
  }
}

class SSHBuilder implements Builder<SSH, SSHBuilder> {
  _$SSH _$v;

  bool _running;
  bool get running => _$this._running;
  set running(bool running) => _$this._running = running;

  SSHBuilder();

  SSHBuilder get _$this {
    if (_$v != null) {
      _running = _$v.running;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SSH other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SSH;
  }

  @override
  void update(void updates(SSHBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SSH build() {
    final _$result = _$v ?? new _$SSH._(running: running);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
