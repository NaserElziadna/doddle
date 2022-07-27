import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:doddle/models/draw_controller.dart';
import 'package:doddle/recorder_bloc/recorder_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doddle/doddler_bloc/doddler_event.dart';
import 'package:screen_recorder/screen_recorder.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_state.dart';
import 'models/point.dart';
import 'painting/last_image_as_background.dart';
import 'painting/sketcher.dart';
import 'recorder_bloc/recorder_event.dart';
import 'utils/single_gesture_recognizer.dart';

class Doddler extends StatefulWidget {
  static GlobalKey? globalKey = GlobalKey();

  const Doddler({Key? key}) : super(key: key);

  @override
  _DoddlerState createState() => _DoddlerState();
}

class _DoddlerState extends State<Doddler> {
  static Size kCanvasSize = Size.zero;
  double symmetryLines = 0;
  DrawController? drawController;
  late bool ignorePointer;
  late int pointerCount;

  @override
  initState() {
    context.read<RecorderBloc>().add(StartRecordingEvent());
    drawController = context.read<DoddlerBloc>().drawController;
    ignorePointer = false;
    pointerCount = 1;
    if (drawController!.globalKey == null) {
      BlocProvider.of<DoddlerBloc>(context)
          .add(InitGlobalKeyEvent(Doddler.globalKey!));
    }
    super.initState();
  }

  // Future<ui.Image> getUiImage(
  //     String imageAssetPath, int height, int width) async {
  //   final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  //   final codec = await ui.instantiateImageCodec(
  //     assetImageByteData.buffer.asUint8List(),
  //     targetHeight: height,
  //     targetWidth: width,
  //   );
  //   final image = (await codec.getNextFrame()).image;
  //   return image;
  // }

  // _loadImage(int height, int width) async {
  //   ByteData bd = await rootBundle.load("assets/brush.png");

  //   final Uint8List bytes = Uint8List.view(bd.buffer);

  //   final ui.Codec codec = await ui.instantiateImageCodec(
  //     bytes.buffer.asUint8List(),
  //     targetHeight: height,
  //     targetWidth: width,
  //   );

  //   final ui.Image image = (await codec.getNextFrame()).image;

  //   setState(() => _image = image);
  // }

  @override
  Widget build(BuildContext context) {
    drawController = context.read<DoddlerBloc>().drawController;
    return BlocConsumer<DoddlerBloc, DoddlerState>(
      listener: (context, state) {
        if (state is MessageState) {
          showDialog(
              context: context,
              builder: (coontext) {
                return AlertDialog(
                  title: const Text("Message"),
                  content: Text(state.message),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (state.isClear) {
                            context
                                .read<DoddlerBloc>()
                                .add(ClearStampsEvent(ok: true));
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"))
                  ],
                );
              });
        }
      },
      builder: (context, state) {
        if (state is UpdateCanvasState) {
          return InteractiveViewer(
            panEnabled: false,
            scaleEnabled: true,
            minScale: 0.1,
            maxScale: 5,
            boundaryMargin: const EdgeInsets.all(80),
            onInteractionEnd: (details) {
              setState(() {
                ignorePointer = details.pointerCount > 1;
                pointerCount = 1;
                BlocProvider.of<DoddlerBloc>(context).add(
                  AddPointEvent(
                      point: Point(
                          offset: null,
                          paint: Paint()
                            ..color = Color.fromRGBO(Random().nextInt(255),
                                Random().nextInt(255), Random().nextInt(255), 1)
                            ..strokeCap = StrokeCap.square
                            ..strokeJoin = StrokeJoin.bevel
                            ..strokeWidth = (Random().nextInt(10)) * 1.0),
                      end: false),
                );
                print(
                    "onInteractionEnd = ignorePointer = $ignorePointer  fingers = ${details.pointerCount}");
              });
            },
            onInteractionUpdate: (details) {
              setState(() {
                ignorePointer = details.pointerCount > 1;
                pointerCount = details.pointerCount;
                print(
                    "onInteractionUpdate = ignorePointer = $ignorePointer  fingers = ${details.pointerCount}");
              });
            },
            onInteractionStart: (details) {
              setState(() {
                ignorePointer = details.pointerCount > 1;
                pointerCount = details.pointerCount;
                print(
                    "onInteractionStart = ignorePointer = $ignorePointer  fingers = ${details.pointerCount}");
              });
            },
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 150,
                left: 20,
                right: 20,
                top: 100,
              ),
              color: Colors.black,
              child: IgnorePointer(
                ignoring: false,
                child: RawGestureDetector(
                  behavior: HitTestBehavior.opaque,
                  gestures: <Type, GestureRecognizerFactory>{
                    SingleGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<
                                SingleGestureRecognizer>(
                            () => SingleGestureRecognizer(debugOwner: this),
                            (instance) {
                      instance.onStart = (pointerEvent) {
                        if (ignorePointer == false && pointerCount == 1) {
                          if (state.drawController != null &&
                              state.drawController!.isRandomColor) {
                            BlocProvider.of<DoddlerBloc>(context).add(
                              ChangeCurrentColorEvent(
                                Color.fromRGBO(
                                    Random().nextInt(255),
                                    Random().nextInt(255),
                                    Random().nextInt(255),
                                    1),
                                true,
                              ),
                            );
                          }
                          // if (drawController!.penTool == PenTool.customPen) {
                          //   BlocProvider.of<DoddlerBloc>(context)
                          //       .add(AddRandomPoints([
                          //     List.generate(
                          //         10,
                          //         (index) => randomOffsets.add(Offset(
                          //             points[j]!.offset!.dx +
                          //                 Random().nextInt(a) * 1.0,
                          //             points[j]!.offset!.dy -
                          //                 Random().nextInt(a) * 1.0)))
                          //   ]));
                          // }
                        }
                      };
                      instance.onUpdate = (pointerEvent) {
                        if (ignorePointer == false && pointerCount == 1) {
                          // print(pointerEvent.pointer);
                          setState(() {
                            kCanvasSize = Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height -
                                    (AppBar().preferredSize.height));
                            var pinSpaceX = -20;
                            var pinSpaceY = -160;

                            Offset point = pointerEvent.localPosition;

                            point = point.translate(
                                -((kCanvasSize.width / 2) + pinSpaceX),
                                -((kCanvasSize.height / 2) + pinSpaceY));

                            // print("x = ${point.dx} , y = ${point.dy}");
                            BlocProvider.of<DoddlerBloc>(context).add(
                                AddPointEvent(
                                    point: Point(
                                        offset: point,
                                        paint: Paint()
                                          ..color = state.drawController == null
                                              ? Colors.white
                                              : state
                                                  .drawController!.currentColor
                                          ..strokeCap = StrokeCap.round
                                          ..strokeJoin = StrokeJoin.miter
                                          ..strokeWidth =
                                              (Random().nextInt(10)) * 1.0)));
                          });
                        }
                      };
                      instance.onEnd = (pointerEvent) {
                        if (ignorePointer == false && pointerCount == 1) {
                          BlocProvider.of<DoddlerBloc>(context).add(
                            AddPointEvent(
                                point: Point(
                                    offset: null,
                                    paint: Paint()
                                      ..color = Color.fromRGBO(
                                          Random().nextInt(255),
                                          Random().nextInt(255),
                                          Random().nextInt(255),
                                          1)
                                      ..strokeCap = StrokeCap.square
                                      ..strokeJoin = StrokeJoin.bevel
                                      ..strokeWidth =
                                          (Random().nextInt(10)) * 1.0),
                                end: true),
                          );
                        }
                      };
                    }),
                  },
                  child: RepaintBoundary(
                    key: Doddler.globalKey,
                    child: ClipRect(
                      child: ScreenRecorder(
                        background:  Colors.black,
                         height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    controller:
                        context.read<RecorderBloc>().recorderController!,
                        child: CustomPaint(
                          foregroundPainter: Sketcher(
                            state.drawController?.points ?? [],
                            kCanvasSize,
                            state.drawController != null
                                ? state.drawController!.symmetryLines!
                                : 5,
                            state.drawController != null
                                ? state.drawController!.currentColor
                                : Colors.red,
                            drawController!.penTool!,
                            drawController!.penSize ?? 1 
                          ),
                          painter: LastImageAsBackground(
                            image: state.drawController == null
                                ? null
                                : state.drawController!.stamp!.isEmpty
                                    ? null
                                    : state.drawController!.stamp!.last!.image,
                          ),
                          size: Size(
                            kCanvasSize.width / 2,
                            kCanvasSize.height / 2,
                          ),
                          willChange: true,
                          isComplex: true,
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }
}
