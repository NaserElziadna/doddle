import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'frame.dart';

class RecorderController {
  final GlobalKey? globalKey;
  final List<Frame>? frames;
  RecorderController({
    this.globalKey,
    this.frames,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecorderController &&
        other.globalKey == globalKey &&
        listEquals(other.frames, frames);
  }

  @override
  int get hashCode => globalKey.hashCode ^ frames.hashCode;

  @override
  String toString() =>
      'RecorderController(globalKey: $globalKey, frames: $frames)';

  RecorderController copyWith({
    GlobalKey? globalKey,
    List<Frame>? frames,
  }) {
    return RecorderController(
      globalKey: globalKey ?? this.globalKey,
      frames: frames ?? this.frames,
    );
  }
}
