import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.freezed.dart';

@freezed
class Point with _$Point {
  const factory Point({
    Offset? offset,
    Paint? paint,
    double? pressure,
    @Default([]) List<Offset>? randomOffset,
  }) = _Point;
}
