// GENERATED CODE - DO NOT MODIFY BY HAND

part of samba;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Samba> _$sambaSerializer = new _$SambaSerializer();

class _$SambaSerializer implements StructuredSerializer<Samba> {
  @override
  final Iterable<Type> types = const [Samba, _$Samba];
  @override
  final String wireName = 'Samba';

  @override
  Iterable<Object> serialize(Serializers serializers, Samba object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'running',
      serializers.serialize(object.running,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Samba deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SambaBuilder();

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

class _$Samba extends Samba {
  @override
  final bool running;

  factory _$Samba([void Function(SambaBuilder) updates]) =>
      (new SambaBuilder()..update(updates)).build();

  _$Samba._({this.running}) : super._() {
    if (running == null) {
      throw new BuiltValueNullFieldError('Samba', 'running');
    }
  }

  @override
  Samba rebuild(void Function(SambaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SambaBuilder toBuilder() => new SambaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Samba && running == other.running;
  }

  @override
  int get hashCode {
    return $jf($jc(0, running.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Samba')..add('running', running))
        .toString();
  }
}

class SambaBuilder implements Builder<Samba, SambaBuilder> {
  _$Samba _$v;

  bool _running;
  bool get running => _$this._running;
  set running(bool running) => _$this._running = running;

  SambaBuilder();

  SambaBuilder get _$this {
    if (_$v != null) {
      _running = _$v.running;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Samba other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Samba;
  }

  @override
  void update(void Function(SambaBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Samba build() {
    final _$result = _$v ?? new _$Samba._(running: running);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
