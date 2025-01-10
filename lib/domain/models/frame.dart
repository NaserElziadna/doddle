import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'frame.freezed.dart';

@freezed
class Frame with _$Frame {
  const factory Frame({
    required Duration timestamp,
    required Image? frame,
  }) = _Frame;
}
