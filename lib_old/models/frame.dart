import 'dart:ui' as ui;

class Frame {
  ui.Image? frame;
  final int? index;

  Frame({
    this.frame,
    this.index,
  });
  Frame copyWith({
    ui.Image? frame,
    int? index,
  }) {
    return Frame(
      frame: frame ?? this.frame,
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'Frame(frame: $frame, index: $index)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Frame && other.frame == frame && other.index == index;
  }

  @override
  int get hashCode => frame.hashCode ^ index.hashCode;
}
