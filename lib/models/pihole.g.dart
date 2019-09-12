// GENERATED CODE - DO NOT MODIFY BY HAND

part of pihole;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Pihole> _$piholeSerializer = new _$PiholeSerializer();

class _$PiholeSerializer implements StructuredSerializer<Pihole> {
  @override
  final Iterable<Type> types = const [Pihole, _$Pihole];
  @override
  final String wireName = 'Pihole';

  @override
  Iterable<Object> serialize(Serializers serializers, Pihole object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'running',
      serializers.serialize(object.running,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Pihole deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PiholeBuilder();

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

class _$Pihole extends Pihole {
  @override
  final bool running;

  factory _$Pihole([void Function(PiholeBuilder) updates]) =>
      (new PiholeBuilder()..update(updates)).build();

  _$Pihole._({this.running}) : super._() {
    if (running == null) {
      throw new BuiltValueNullFieldError('Pihole', 'running');
    }
  }

  @override
  Pihole rebuild(void Function(PiholeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PiholeBuilder toBuilder() => new PiholeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Pihole && running == other.running;
  }

  @override
  int get hashCode {
    return $jf($jc(0, running.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Pihole')..add('running', running))
        .toString();
  }
}

class PiholeBuilder implements Builder<Pihole, PiholeBuilder> {
  _$Pihole _$v;

  bool _running;
  bool get running => _$this._running;
  set running(bool running) => _$this._running = running;

  PiholeBuilder();

  PiholeBuilder get _$this {
    if (_$v != null) {
      _running = _$v.running;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Pihole other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Pihole;
  }

  @override
  void update(void Function(PiholeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Pihole build() {
    final _$result = _$v ?? new _$Pihole._(running: running);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
