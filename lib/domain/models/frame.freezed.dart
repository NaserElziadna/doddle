// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Frame {
  Duration get timestamp => throw _privateConstructorUsedError;
  Image? get frame => throw _privateConstructorUsedError;

  /// Create a copy of Frame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrameCopyWith<Frame> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameCopyWith<$Res> {
  factory $FrameCopyWith(Frame value, $Res Function(Frame) then) =
      _$FrameCopyWithImpl<$Res, Frame>;
  @useResult
  $Res call({Duration timestamp, Image? frame});
}

/// @nodoc
class _$FrameCopyWithImpl<$Res, $Val extends Frame>
    implements $FrameCopyWith<$Res> {
  _$FrameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Frame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? frame = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Duration,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as Image?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrameImplCopyWith<$Res> implements $FrameCopyWith<$Res> {
  factory _$$FrameImplCopyWith(
          _$FrameImpl value, $Res Function(_$FrameImpl) then) =
      __$$FrameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration timestamp, Image? frame});
}

/// @nodoc
class __$$FrameImplCopyWithImpl<$Res>
    extends _$FrameCopyWithImpl<$Res, _$FrameImpl>
    implements _$$FrameImplCopyWith<$Res> {
  __$$FrameImplCopyWithImpl(
      _$FrameImpl _value, $Res Function(_$FrameImpl) _then)
      : super(_value, _then);

  /// Create a copy of Frame
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? frame = freezed,
  }) {
    return _then(_$FrameImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as Duration,
      frame: freezed == frame
          ? _value.frame
          : frame // ignore: cast_nullable_to_non_nullable
              as Image?,
    ));
  }
}

/// @nodoc

class _$FrameImpl implements _Frame {
  const _$FrameImpl({required this.timestamp, required this.frame});

  @override
  final Duration timestamp;
  @override
  final Image? frame;

  @override
  String toString() {
    return 'Frame(timestamp: $timestamp, frame: $frame)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrameImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.frame, frame) || other.frame == frame));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, frame);

  /// Create a copy of Frame
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrameImplCopyWith<_$FrameImpl> get copyWith =>
      __$$FrameImplCopyWithImpl<_$FrameImpl>(this, _$identity);
}

abstract class _Frame implements Frame {
  const factory _Frame(
      {required final Duration timestamp,
      required final Image? frame}) = _$FrameImpl;

  @override
  Duration get timestamp;
  @override
  Image? get frame;

  /// Create a copy of Frame
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrameImplCopyWith<_$FrameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
