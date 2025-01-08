import 'package:doddle/application/providers/canvas/canvas_provider.dart';
import 'package:doddle/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorToolGrid extends ConsumerStatefulWidget {
  const ColorToolGrid({Key? key}) : super(key: key);

  @override
  ConsumerState<ColorToolGrid> createState() => _ColorToolGridState();
}

class _ColorToolGridState extends ConsumerState<ColorToolGrid> {
  Color pickerColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.green,
      Colors.black,
      Colors.blue,
      Colors.red,
      Colors.grey,
      Colors.yellow,
      Colors.purple,
      Colors.indigo,
      Colors.lime,
      Colors.orange,
      "Random Color",
      "Color Picker"
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: colors.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          final color = colors[index];

          if (color is Color) {
            return _buildColorCircle(color);
          } else if (color == "Random Color") {
            return _buildRandomColorButton();
          } else if (color == "Color Picker") {
            return _buildColorPickerButton();
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ref.read(canvasNotifierProvider.notifier).changeColor(color, false);
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white70, width: 3),
          ),
        ),
      ),
    );
  }

  Widget _buildRandomColorButton() {
    return GestureDetector(
      onTap: () {
        ref
            .read(canvasNotifierProvider.notifier)
            .changeColor(Colors.green, true);
        Navigator.of(context).pop();
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Assets.svg.colorBorder.svg(width: 60),
          Assets.svg.randomColor.svg(width: 50),
        ],
      ),
    );
  }

  Widget _buildColorPickerButton() {
    return IconButton(
      icon: const Icon(
        Icons.color_lens,
        color: Colors.red,
        size: 60,
      ),
      onPressed: () => _showColorPicker(),
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                ref
                    .read(canvasNotifierProvider.notifier)
                    .changeColor(pickerColor, false);
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close bottom sheet
              },
            ),
          ],
        );
      },
    );
  }
}
