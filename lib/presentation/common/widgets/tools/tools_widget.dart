import 'package:doddle/application/providers/config/config_provider.dart';
import 'package:doddle/domain/models/draw_controller.dart';
import 'package:doddle/domain/value_objects/tool_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/generated/assets.gen.dart';
import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/presentation/common/widgets/popover.dart';
import 'brush_tool_grid.dart';
import 'color_tool_grid.dart';
import 'symmetry_tool_grid.dart';
import 'canvas_settings_tool_grid.dart';

class ToolsWidget extends ConsumerWidget {
  const ToolsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      color: Colors.purple[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildToolButton(
            context,
            icon: Assets.svg.pen.svg(width: 50),
            toolType: ToolType.brushs,
          ),
          _buildEraserButton(ref),
          Consumer(builder: (context, ref, child) {
            final selectedSymmetryLines =
                ref.watch(canvasNotifierProvider).symmetryLines ?? 1;
            final isMirrorSymmetry =
                ref.watch(canvasNotifierProvider).mirrorSymmetry ;

            final symmetryLines = ref.watch(configProvider).symmetryLines;

            final selectedLine = symmetryLines.firstWhere(
              (line) =>
                  line.count == selectedSymmetryLines &&
                  line.isMirror == isMirrorSymmetry,
              orElse: () => symmetryLines.first,
            );

            return _buildToolButton(
              context,
              icon: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Assets.svg.symmetricalLineBg.svg(width: 80),
                  selectedLine.picture,
                ],
              ),
              toolType: ToolType.symmyrticllLine,
            );
          }),
          _buildToolButton(
            context,
            icon: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Assets.svg.colorBorder.svg(width: 70),
                Assets.svg.randomColor.svg(width: 61),
              ],
            ),
            toolType: ToolType.colors,
          ),
          _buildToolButton(
            context,
            icon: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
            toolType: ToolType.canvasSettings,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(
    BuildContext context, {
    required Widget icon,
    required ToolType toolType,
  }) {
    return GestureDetector(
      onTap: () => _showToolSettings(context, toolType),
      child: icon,
    );
  }

  Widget _buildEraserButton(WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(canvasNotifierProvider.notifier)
            .changePenTool(PenTool.eraserPen);
      },
      child: Assets.svg.eraser.svg(width: 60),
    );
  }

  void _showToolSettings(BuildContext context, ToolType toolType) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Popover(
          child: _buildToolContent(toolType),
        );
      },
    );
  }

  Widget _buildToolContent(ToolType toolType) {
    switch (toolType) {
      case ToolType.brushs:
        return const BrushToolGrid();
      case ToolType.colors:
        return const ColorToolGrid();
      case ToolType.symmyrticllLine:
        return const SymmetryToolGrid();
      case ToolType.canvasSettings:
        return const CanvasSettingsToolGrid();
    }
  }
}
