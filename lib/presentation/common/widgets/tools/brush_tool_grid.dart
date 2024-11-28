import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/value_objects/tool_types.dart';
import 'package:doddle/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrushToolGrid extends ConsumerWidget {
  const BrushToolGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brushes = [
      BrushTool(penTool: PenTool.glowPen, picture: Assets.svg.pen1Preview.svg()),
      BrushTool(penTool: PenTool.normalPen, picture: Assets.svg.pen2Preview.svg()),
      BrushTool(penTool: PenTool.glowWithDotsPen, picture: Assets.svg.pen5Preview.svg()),
      BrushTool(penTool: PenTool.normalWithShaderPen, picture: Assets.svg.pen6Preview.svg()),
      BrushTool(penTool: PenTool.sprayPen, picture: Assets.svg.pen3Preview.svg()),
    ];

    final selectedPenTool = ref.watch(canvasProvider).penTool;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: brushes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final brush = brushes[index];
        final isSelected = brush.penTool == selectedPenTool;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              ref.read(canvasProvider.notifier).changePenTool(brush.penTool);
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.black,
                  width: isSelected ? 4 : 3,
                ),
              ),
              child: brush.picture,
            ),
          ),
        );
      },
    );
  }
}
