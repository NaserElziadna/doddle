import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/application/providers/config/config_provider.dart';
import 'package:doddle/domain/value_objects/tool_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/generated/assets.gen.dart';

class SymmetryToolGrid extends ConsumerWidget {
  const SymmetryToolGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symmetryLines = ref.watch(configProvider).symmetryLines;
    final selectedSymmetryLines = ref.watch(canvasNotifierProvider).symmetryLines ?? 1;
    final isMirrorSymmetry = ref.watch(canvasNotifierProvider).mirrorSymmetry ?? false;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: symmetryLines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        final line = symmetryLines[index];
        final isSelected = line.count == selectedSymmetryLines && 
                         line.isMirror == isMirrorSymmetry;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              ref.read(canvasNotifierProvider.notifier).updateSymmetryLines(line.count);
              ref.read(canvasNotifierProvider.notifier).toggleMirrorSymmetry(line.isMirror);
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
              child: line.picture,
            ),
          ),
        );
      },
    );
  }
}
