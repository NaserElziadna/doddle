import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:doddle/doddler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/rendering.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'dot.dart';
import 'tools_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoddlerBloc(points: []),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Sketcher'),
              backgroundColor: Colors.purple,
              // actions: [
              //   // Center(child: Text(symmetryLines.toStringAsFixed(3))),
              //   // Slider(
              //   //   value: symmetryLines,
              //   //   max: 20,
              //   //   min: 0,
              //   //   activeColor: Colors.redAccent,
              //   //   label: "S L",
              //   //   thumbColor: Colors.black,
              //   //   inactiveColor: Colors.green,
              //   //   onChanged: (value) {
              //   //     setState(() {
              //   //       symmetryLines = value;
              //   //     });
              //   //   },
              //   // )
              // ],
            ),
            body: Container(
              color: Colors.purple[700],
              child: const Doddler(),
            ),
            bottomSheet: const ToolsWidget(),
            // floatingActionButton: FloatingActionButton(
            //   tooltip: 'clear Screen',
            //   backgroundColor: Colors.red,
            //   child: const Icon(Icons.refresh),
            //   onPressed: () {
            //     setState(() => points.clear());
            //   },
            // ),
          )),
    );
  }

  // Future<void> saveimage() async {
  //   RenderRepaintBoundary? boundary =
  //       _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
  //   ui.Image image = await boundary!.toImage();
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData!.buffer.asUint8List();

  //   //Request permissions if not already granted
  //   if (!(await Permission.storage.status.isGranted))
  //     await Permission.storage.request();

  //   final result = await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(pngBytes),
  //       quality: 60,
  //       name: "canvas_image");
  //   print(result);
  // }
}
