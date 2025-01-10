import 'package:flutter/material.dart';

class CanvasSize {
  final String name;
  final Size size;

  const CanvasSize({
    required this.name,
    required this.size,
  });
}

class CanvasSizeDialog extends StatelessWidget {
  CanvasSizeDialog({Key? key}) : super(key: key);

  final List<CanvasSize> canvasSizes = [
    CanvasSize(name: 'Small (1080x1080)', size: const Size(1080, 1080)),
    CanvasSize(name: 'Medium (1920x1080)', size: const Size(1920, 1080)),
    CanvasSize(name: 'Large (2560x1440)', size: const Size(2560, 1440)),
    CanvasSize(name: 'Custom', size: Size.zero),
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Canvas Size'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: canvasSizes.map((size) {
            return ListTile(
              title: Text(size.name),
              onTap: () {
                if (size.name == 'Custom') {
                  _showCustomSizeDialog(context);
                } else {
                  Navigator.of(context).pop(size.size);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCustomSizeDialog(BuildContext context) {
    final widthController = TextEditingController();
    final heightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: widthController,
              decoration: const InputDecoration(labelText: 'Width'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: heightController,
              decoration: const InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final width = double.tryParse(widthController.text);
              final height = double.tryParse(heightController.text);
              if (width != null && height != null) {
                Navigator.of(context).pop();
                Navigator.of(context).pop(Size(width, height));
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
} 