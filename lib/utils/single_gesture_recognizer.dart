
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// [GestureRecognizer] that allows just one input pointer.
class SingleGestureRecognizer extends OneSequenceGestureRecognizer {
  @override
  String get debugDescription => 'single_gesture_recognizer';

  ValueChanged<Offset>? onStart;
  ValueChanged<Offset>? onUpdate;
  ValueChanged<Offset>? onEnd;

  bool pointerActive = false;

  SingleGestureRecognizer({
    Object? debugOwner,
    PointerDeviceKind? kind,
  }) : super(
          debugOwner: debugOwner,
          kind: kind,
        );

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (pointerActive) {
      return;
    }

    startTrackingPointer(event.pointer, event.transform);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onUpdate?.call(event.position);
    } else if (event is PointerDownEvent) {
      pointerActive = true;
      onStart?.call(event.position);
    } else if (event is PointerUpEvent) {
      pointerActive = false;
      onEnd?.call(event.position);
    } else if (event is PointerCancelEvent) {
      pointerActive = false;
      onEnd?.call(event.position);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
