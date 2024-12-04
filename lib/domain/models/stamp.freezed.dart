// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Stamp {
  ui.Image get image => throw _privateConstructorUsedError;

  /// Create a copy of Stamp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StampCopyWith<Stamp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StampCopyWith<$Res> {
  factory $StampCopyWith(Stamp value, $Res Function(Stamp) then) =
      _$StampCopyWithImpl<$Res, Stamp>;
  @useResult
  $Res call({ui.Image image});
}

/// @nodoc
class _$StampCopyWithImpl<$Res, $Val extends Stamp>
    implements $StampCopyWith<$Res> {
  _$StampCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Stamp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as ui.Image,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StampImplCopyWith<$Res> implements $StampCopyWith<$Res> {
  factory _$$StampImplCopyWith(
          _$StampImpl value, $Res Function(_$StampImpl) then) =
      __$$StampImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ui.Image image});
}

/// @nodoc
class __$$StampImplCopyWithImpl<$Res>
    extends _$StampCopyWithImpl<$Res, _$StampImpl>
    implements _$$StampImplCopyWith<$Res> {
  __$$StampImplCopyWithImpl(
      _$StampImpl _value, $Res Function(_$StampImpl) _then)
      : super(_value, _then);

  /// Create a copy of Stamp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
  }) {
    return _then(_$StampImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as ui.Image,
    ));
  }
}

/// @nodoc

class _$StampImpl implements _Stamp {
  const _$StampImpl({required this.image});

  @override
  final ui.Image image;

  @override
  String toString() {
    return 'Stamp(image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StampImpl &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  /// Create a copy of Stamp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StampImplCopyWith<_$StampImpl> get copyWith =>
      __$$StampImplCopyWithImpl<_$StampImpl>(this, _$identity);
}

abstract class _Stamp implements Stamp {
  const factory _Stamp({required final ui.Image image}) = _$StampImpl;

  @override
  ui.Image get image;

  /// Create a copy of Stamp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StampImplCopyWith<_$StampImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
