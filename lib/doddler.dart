import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:doddle/draw_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:doddle/doddler_bloc/doddler_event.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_state.dart';
import 'point.dart';
import 'tools_widget.dart';

class Doddler extends StatefulWidget {
  const Doddler({Key? key}) : super(key: key);

  @override
  _DoddlerState createState() => _DoddlerState();
}

class _DoddlerState extends State<Doddler> {
  // List<Point?> points = [];
  // List<ByteData?> imgsBytes = [];
  GlobalKey? globalKey = GlobalKey();

  static Size kCanvasSize = Size.zero;
  double symmetryLines = 0;
  DrawController? drawController;

  @override
  void initState() {
    drawController = context.read<DoddlerBloc>().drawController;
    print(drawController!.toString());
    if (drawController!.globalKey == null)
      BlocProvider.of<DoddlerBloc>(context).add(InitGlobalKeyEvent(globalKey!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoddlerBloc, DoddlerState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UpdateCanvasState) {
          return Center(
            child: Container(
              // width: MediaQuery.of(context).size.width * 0.8,
              // height: MediaQuery.of(context).size.height * 0.75,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
              color: Colors.black,
              child: RawGestureDetector(
                behavior: HitTestBehavior.opaque,
                gestures: <Type, GestureRecognizerFactory>{
                  _SingleGestureRecognizer:
                      GestureRecognizerFactoryWithHandlers<
                          _SingleGestureRecognizer>(
                    () => _SingleGestureRecognizer(debugOwner: this),
                    (instance) {
                      // instance.onStart = (position) => _startPath(position);
                      instance.onUpdate = (position) {
                        setState(() {
                          kCanvasSize = Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height -
                                  (AppBar().preferredSize.height));
                          const pinSpace = 50;

                          // RenderBox box =
                          // context.findRenderObject() as RenderBox;
                          // Offset point =
                          // box.globalToLocal(details.globalPosition);
                          Offset point = position;

                          point = point.translate(-(kCanvasSize.width / 2),
                              -((kCanvasSize.height / 2) + pinSpace));

                          print("x = ${point.dx} , y = ${point.dy}");
                          BlocProvider.of<DoddlerBloc>(context).add(
                              AddPointEvent(Point(
                                  offset: point,
                                  paint: Paint()
                                    ..color = state.drawController == null
                                        ? Colors.white
                                        : state.drawController!.currentColor
                                    ..strokeCap = StrokeCap.round
                                    ..strokeJoin = StrokeJoin.miter
                                    ..strokeWidth =
                                        (Random().nextInt(10)) * 1.0)));
                        });
                      };
                      instance.onEnd = (position) => {
                            BlocProvider.of<DoddlerBloc>(context).add(
                                AddPointEvent(
                                    Point(
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
                                    end: true))
                            //         context
                            // .read<DoddlerBloc>()
                            // .add(TakePageStampEvent(globalKey!));
                          };
                    },
                  ),
                },
                child: RepaintBoundary(
                  key: globalKey,
                  child: ClipRect(
                    child: CustomPaint(
                      foregroundPainter: Sketcher(
                          state.drawController?.points ?? [],
                          kCanvasSize,
                          state.drawController != null
                              ? state.drawController!.symmetryLines!
                              : 5,
                          state.drawController != null
                              ? state.drawController!.currentColor
                              : Colors.red),
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

/// [GestureRecognizer] that allows just one input pointer.
class _SingleGestureRecognizer extends OneSequenceGestureRecognizer {
  @override
  String get debugDescription => 'single_gesture_recognizer';

  ValueChanged<Offset>? onStart;
  ValueChanged<Offset>? onUpdate;
  ValueChanged<Offset>? onEnd;

  bool pointerActive = false;

  _SingleGestureRecognizer({
    Object? debugOwner,
    PointerDeviceKind? kind,
  }) : super(
          debugOwner: debugOwner,
          kind: kind,
        );

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (pointerActive) {
      return;
    }

    startTrackingPointer(event.pointer, event.transform);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      onUpdate?.call(event.position);
    } else if (event is PointerDownEvent) {
      pointerActive = true;
      onStart?.call(event.position);
    } else if (event is PointerUpEvent) {
      pointerActive = false;
      onEnd?.call(event.position);
    } else if (event is PointerCancelEvent) {
      pointerActive = false;
      onEnd?.call(event.position);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}
}

class LastImageAsBackground extends CustomPainter {
  ui.Image? image;
  LastImageAsBackground({
    required this.image,
  });
  @override
  void paint(Canvas canvas, Size size) {
    if (image != null) {
      print("=entered=");
      canvas.drawImage(image!, Offset.zero, Paint());
    }
    print("=out=");
  }

  @override
  bool shouldRepaint(LastImageAsBackground oldDelegate) {
    return oldDelegate.image != image;
  }
}

class Sketcher extends CustomPainter {
  final List<Point?> points;
  final Size screenSize;
  final double symmetryLines;
  final Color color;

  Sketcher(this.points, this.screenSize, this.symmetryLines, this.color);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size.toString());
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    var angle = 360 / (symmetryLines);

    print(angle);
    Path path = Path();
    for (var j = 0; j < points.length - 1; j++) {
      if (points[j + 1] != null) {
        if (points[j]!.offset != null && points[j + 1]!.offset != null) {
          path.moveTo(points[j]!.offset!.dx, points[j]!.offset!.dy);
          path.lineTo(points[j + 1]!.offset!.dx, points[j + 1]!.offset!.dy);
        }
      } else {
        j++;
      }
    }

    print(color);
    for (var i = 0; i <= symmetryLines; i++) {
      canvas.drawPath(
          path,
          Paint()
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0)
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10.0);

      canvas.drawPath(path, paint);
      canvas.rotate(angle);
    }
  }
}
