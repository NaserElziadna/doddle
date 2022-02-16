import 'package:flutter/material.dart';

class SymmetryLinePicker extends CustomPainter {
  final double symmetryLine;
  SymmetryLinePicker({
    required this.symmetryLine,
  });
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < symmetryLine; i++) {
      canvas.drawLine(
        Offset.zero,
        Offset(100, 100),
        Paint(),
      );
      canvas.rotate(symmetryLine / 360);
    }
  }

  @override
  bool shouldRepaint(SymmetryLinePicker oldDelegate) {
    return true;
    // return oldDelegate.symmetryLine != symmetryLine;
  }
}
