import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:ui' as ui;

part 'stamp.freezed.dart';

@freezed
class Stamp with _$Stamp {
  const factory Stamp({
    required ui.Image image,
  }) = _Stamp;
}
