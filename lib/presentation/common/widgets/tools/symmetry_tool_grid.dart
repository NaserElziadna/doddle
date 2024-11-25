import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/domain/value_objects/tool_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doddle/generated/assets.gen.dart';

class SymmetryToolGrid extends ConsumerWidget {
  const SymmetryToolGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symmetryLines = [
      SymmtriclLine(count: 1, picture: Assets.svg.symmetricalLine1.svg()),
      SymmtriclLine(count: 2, picture: Assets.svg.symmetricalLine2.svg()),
      SymmtriclLine(count: 3, picture: Assets.svg.symmetricalLine5.svg()),
      SymmtriclLine(count: 4, picture: Assets.svg.symmetricalLine7.svg()),
      SymmtriclLine(count: 8, picture: Assets.svg.symmetricalLine8.svg()),
      SymmtriclLine(count: 5, picture: Assets.svg.symmetricalLine9.svg()),
      SymmtriclLine(count: 10, picture: Assets.svg.symmetricalLine10.svg()),
      SymmtriclLine(count: 6, picture: Assets.svg.symmetricalLine11.svg()),
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: symmetryLines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        final line = symmetryLines[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              ref.read(canvasProvider.notifier).updateSymmetryLines(line.count);
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: line.picture,
            ),
          ),
        );
      },
    );
  }
}
