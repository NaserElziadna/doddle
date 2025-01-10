// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Point {
  Offset? get offset => throw _privateConstructorUsedError;
  Paint? get paint => throw _privateConstructorUsedError;
  double? get pressure => throw _privateConstructorUsedError;
  List<Offset>? get randomOffset => throw _privateConstructorUsedError;

  /// Create a copy of Point
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointCopyWith<Point> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointCopyWith<$Res> {
  factory $PointCopyWith(Point value, $Res Function(Point) then) =
      _$PointCopyWithImpl<$Res, Point>;
  @useResult
  $Res call(
      {Offset? offset,
      Paint? paint,
      double? pressure,
      List<Offset>? randomOffset});
}

/// @nodoc
class _$PointCopyWithImpl<$Res, $Val extends Point>
    implements $PointCopyWith<$Res> {
  _$PointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Point
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
    Object? paint = freezed,
    Object? pressure = freezed,
    Object? randomOffset = freezed,
  }) {
    return _then(_value.copyWith(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset?,
      paint: freezed == paint
          ? _value.paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Paint?,
      pressure: freezed == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double?,
      randomOffset: freezed == randomOffset
          ? _value.randomOffset
          : randomOffset // ignore: cast_nullable_to_non_nullable
              as List<Offset>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointImplCopyWith<$Res> implements $PointCopyWith<$Res> {
  factory _$$PointImplCopyWith(
          _$PointImpl value, $Res Function(_$PointImpl) then) =
      __$$PointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Offset? offset,
      Paint? paint,
      double? pressure,
      List<Offset>? randomOffset});
}

/// @nodoc
class __$$PointImplCopyWithImpl<$Res>
    extends _$PointCopyWithImpl<$Res, _$PointImpl>
    implements _$$PointImplCopyWith<$Res> {
  __$$PointImplCopyWithImpl(
      _$PointImpl _value, $Res Function(_$PointImpl) _then)
      : super(_value, _then);

  /// Create a copy of Point
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = freezed,
    Object? paint = freezed,
    Object? pressure = freezed,
    Object? randomOffset = freezed,
  }) {
    return _then(_$PointImpl(
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset?,
      paint: freezed == paint
          ? _value.paint
          : paint // ignore: cast_nullable_to_non_nullable
              as Paint?,
      pressure: freezed == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double?,
      randomOffset: freezed == randomOffset
          ? _value._randomOffset
          : randomOffset // ignore: cast_nullable_to_non_nullable
              as List<Offset>?,
    ));
  }
}

/// @nodoc

class _$PointImpl implements _Point {
  const _$PointImpl(
      {this.offset,
      this.paint,
      this.pressure,
      final List<Offset>? randomOffset = const []})
      : _randomOffset = randomOffset;

  @override
  final Offset? offset;
  @override
  final Paint? paint;
  @override
  final double? pressure;
  final List<Offset>? _randomOffset;
  @override
  @JsonKey()
  List<Offset>? get randomOffset {
    final value = _randomOffset;
    if (value == null) return null;
    if (_randomOffset is EqualUnmodifiableListView) return _randomOffset;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Point(offset: $offset, paint: $paint, pressure: $pressure, randomOffset: $randomOffset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.paint, paint) || other.paint == paint) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            const DeepCollectionEquality()
                .equals(other._randomOffset, _randomOffset));
  }

  @override
  int get hashCode => Object.hash(runtimeType, offset, paint, pressure,
      const DeepCollectionEquality().hash(_randomOffset));

  /// Create a copy of Point
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointImplCopyWith<_$PointImpl> get copyWith =>
      __$$PointImplCopyWithImpl<_$PointImpl>(this, _$identity);
}

abstract class _Point implements Point {
  const factory _Point(
      {final Offset? offset,
      final Paint? paint,
      final double? pressure,
      final List<Offset>? randomOffset}) = _$PointImpl;

  @override
  Offset? get offset;
  @override
  Paint? get paint;
  @override
  double? get pressure;
  @override
  List<Offset>? get randomOffset;

  /// Create a copy of Point
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointImplCopyWith<_$PointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
