import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/presentation/painting/brush_preview_painter.dart';
import 'package:sizer/sizer.dart';

class BrushPreview extends ConsumerWidget {
  const BrushPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 20.h,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: BrushPreviewPainter(ref),
      ),
    );
  }
}
