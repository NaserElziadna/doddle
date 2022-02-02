import 'dart:math';

import 'package:doddle/models/draw_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:doddle/doddler_bloc/doddler_event.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_state.dart';
import 'models/point.dart';
import 'painting/last_image_as_background.dart';
import 'painting/sketcher.dart';
import 'utils/single_gesture_recognizer.dart';

class Doddler extends StatefulWidget {
  const Doddler({Key? key}) : super(key: key);

  @override
  _DoddlerState createState() => _DoddlerState();
}

class _DoddlerState extends State<Doddler> {
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
          return InteractiveViewer(
            panEnabled: false,
            minScale: 0.1,
            maxScale: 3,
            boundaryMargin: const EdgeInsets.all(80),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 150,
                  left: 20,
                  right: 20,
                  top: 100,
                ),
                color: Colors.black,
                child: RawGestureDetector(
                  behavior: HitTestBehavior.opaque,
                  gestures: <Type, GestureRecognizerFactory>{
                    SingleGestureRecognizer:
                        GestureRecognizerFactoryWithHandlers<
                            SingleGestureRecognizer>(
                      () => SingleGestureRecognizer(debugOwner: this),
                      (instance) {
                        instance.onStart = (pointerEvent) {
                          BlocProvider.of<DoddlerBloc>(context).add(
                              ChangeCurrentColorEvent(Color.fromRGBO(
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                  Random().nextInt(255),
                                  1)));
                        };
                        instance.onUpdate = (pointerEvent) {
                          print(pointerEvent.pointer);
                          setState(() {
                            kCanvasSize = Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height -
                                    (AppBar().preferredSize.height));
                            var pinSpaceX = -20;
                            var pinSpaceY = -140;

                            // RenderBox box =
                            // context.findRenderObject() as RenderBox;
                            // Offset point =
                            // box.globalToLocal(details.globalPosition);
                            Offset point = pointerEvent.localPosition;

                            point = point.translate(
                                -((kCanvasSize.width / 2) + pinSpaceX),
                                -((kCanvasSize.height / 2) + pinSpaceY));

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
                        instance.onEnd = (pointerEvent) {
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
                                end: true),
                          );
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
