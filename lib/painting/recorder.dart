import 'dart:async';

import 'package:doddle/models/draw_controller.dart';
import 'package:flutter/material.dart';

class Recorder extends CustomPainter {
  Frame frame;
  Recorder({
    required this.frame,
  });
  @override
  void paint(Canvas canvas, Size size) {
    if (frame != null) {
      canvas.drawImage(frame.frame!, Offset.zero, Paint());
    }
    print("=out=");
  }

  @override
  bool shouldRepaint(Recorder oldDelegate) {
    return oldDelegate.frame != frame;
  }
}
