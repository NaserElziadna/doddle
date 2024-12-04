import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/draw_controller.dart';

enum ToolType {
  brushs,
  colors,
  symmyrticllLine,
  canvasSettings,
}

class SymmtriclLine {
  final double count;
  final bool isMirror;
  final SvgPicture picture;
  
  const SymmtriclLine({
    required this.count,
    required this.picture,
    required this.isMirror,
  });
}

class BrushTool {
  final PenTool penTool;
  final SvgPicture picture;
  
  const BrushTool({
    required this.penTool,
    required this.picture,
  });
}