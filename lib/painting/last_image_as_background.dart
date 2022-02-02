import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class LastImageAsBackground extends CustomPainter {
  ui.Image? image;
  LastImageAsBackground({
    required this.image,
  });
  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      print("=entered=");
      canvas.drawImage(image!, Offset.zero, Paint());
    }
    print("=out=");
  }

  @override
  bool shouldRepaint(LastImageAsBackground oldDelegate) {
    return oldDelegate.image != image;
  }
}