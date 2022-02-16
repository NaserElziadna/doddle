import 'dart:ui';

class Point {
  Offset? offset;
  Paint? paint;
  List<Offset>? randomOffset = [];

  Point({
    this.offset,
    this.paint,
    this.randomOffset
  });

  Point copyWith({
    Offset? offset,
    Paint? paint,
  }) {
    return Point(
      offset: offset ?? this.offset,
      paint: paint ?? this.paint,
    );
  }

  @override
  String toString() => 'Point(offset: $offset, paint: $paint)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Point && other.offset == offset && other.paint == paint;
  }

  @override
  int get hashCode => offset.hashCode ^ paint.hashCode;
}
