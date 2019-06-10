// GENERATED CODE - DO NOT MODIFY BY HAND

part of teledart;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Teledart> _$teledartSerializer = new _$TeledartSerializer();

class _$TeledartSerializer implements StructuredSerializer<Teledart> {
  @override
  final Iterable<Type> types = const [Teledart, _$Teledart];
  @override
  final String wireName = 'Teledart';

  @override
  Iterable serialize(Serializers serializers, Teledart object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'running',
      serializers.serialize(object.running,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Teledart deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TeledartBuilder();

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

class _$Teledart extends Teledart {
  @override
  final bool running;

  factory _$Teledart([void Function(TeledartBuilder) updates]) =>
      (new TeledartBuilder()..update(updates)).build();

  _$Teledart._({this.running}) : super._() {
    if (running == null) {
      throw new BuiltValueNullFieldError('Teledart', 'running');
    }
  }

  @override
  Teledart rebuild(void Function(TeledartBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeledartBuilder toBuilder() => new TeledartBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Teledart && running == other.running;
  }

  @override
  int get hashCode {
    return $jf($jc(0, running.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Teledart')..add('running', running))
        .toString();
  }
}

class TeledartBuilder implements Builder<Teledart, TeledartBuilder> {
  _$Teledart _$v;

  bool _running;
  bool get running => _$this._running;
  set running(bool running) => _$this._running = running;

  TeledartBuilder();

  TeledartBuilder get _$this {
    if (_$v != null) {
      _running = _$v.running;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Teledart other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Teledart;
  }

  @override
  void update(void Function(TeledartBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Teledart build() {
    final _$result = _$v ?? new _$Teledart._(running: running);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
