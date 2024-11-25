import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/draw_controller.dart';

enum ToolType {
  colors,
  brushs,
  symmyrticllLine,
}

class SymmtriclLine {
  final double count;
  final SvgPicture picture;
  
  const SymmtriclLine({
    required this.count,
    required this.picture,
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