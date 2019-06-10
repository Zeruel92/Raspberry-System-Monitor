// GENERATED CODE - DO NOT MODIFY BY HAND

part of disk;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DiskModel> _$diskModelSerializer = new _$DiskModelSerializer();

class _$DiskModelSerializer implements StructuredSerializer<DiskModel> {
  @override
  final Iterable<Type> types = const [DiskModel, _$DiskModel];
  @override
  final String wireName = 'DiskModel';

  @override
  Iterable serialize(Serializers serializers, DiskModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'df',
      serializers.serialize(object.df, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DiskModel deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DiskModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'df':
          result.df = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$DiskModel extends DiskModel {
  @override
  final String df;

  factory _$DiskModel([void Function(DiskModelBuilder) updates]) =>
      (new DiskModelBuilder()..update(updates)).build();

  _$DiskModel._({this.df}) : super._() {
    if (df == null) {
      throw new BuiltValueNullFieldError('DiskModel', 'df');
    }
  }

  @override
  DiskModel rebuild(void Function(DiskModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiskModelBuilder toBuilder() => new DiskModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DiskModel && df == other.df;
  }

  @override
  int get hashCode {
    return $jf($jc(0, df.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DiskModel')..add('df', df)).toString();
  }
}

class DiskModelBuilder implements Builder<DiskModel, DiskModelBuilder> {
  _$DiskModel _$v;

  String _df;
  String get df => _$this._df;
  set df(String df) => _$this._df = df;

  DiskModelBuilder();

  DiskModelBuilder get _$this {
    if (_$v != null) {
      _df = _$v.df;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DiskModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DiskModel;
  }

  @override
  void update(void Function(DiskModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DiskModel build() {
    final _$result = _$v ?? new _$DiskModel._(df: df);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
