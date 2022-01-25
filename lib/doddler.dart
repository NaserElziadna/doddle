import 'dart:math';
import 'package:doddle/doddler_bloc/doddler_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_state.dart';
import 'dot.dart';

class Doddler extends StatefulWidget {
  const Doddler({Key? key}) : super(key: key);

  @override
  _DoddlerState createState() => _DoddlerState();
}

class _DoddlerState extends State<Doddler> {
  List<Dot?> points = [];
  // List<ByteData?> imgsBytes = [];
  double symmetryLines = 0;

  static Size kCanvasSize = Size.zero;
  // GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoddlerBloc, DoddlerState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        if (state is PagePointsState) {
          return Container(
            margin: const EdgeInsets.all(20),
            color: Colors.black,
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  kCanvasSize = Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height -
                          (AppBar().preferredSize.height));
                  const pinSpace = 0;

                  RenderBox box = context.findRenderObject() as RenderBox;
                  Offset point = box.globalToLocal(details.globalPosition);

                  point = point.translate(-(kCanvasSize.width / 2),
                      -((kCanvasSize.height / 2) + pinSpace));

                  print("x = ${point.dx} , y = ${point.dy}");
                  BlocProvider.of<DoddlerBloc>(context).add(AddPointEvent(Dot(
                      offset: point,
                      paint: Paint()
                        ..color = Color.fromRGBO(Random().nextInt(255),
                            Random().nextInt(255), Random().nextInt(255), 1)
                        ..strokeCap = StrokeCap.round
                        ..strokeJoin = StrokeJoin.miter
                        ..strokeWidth = (Random().nextInt(10)) * 1.0)));
                  // points = List.from(points)
                  //   ..add(Dot(
                  //       offset: point,
                  //       paint: Paint()
                  //         ..color = Color.fromRGBO(Random().nextInt(255),
                  //             Random().nextInt(255), Random().nextInt(255), 1)
                  //         ..strokeCap = StrokeCap.round
                  //         ..strokeJoin = StrokeJoin.miter
                  //         ..strokeWidth = (Random().nextInt(10)) * 1.0));
                });
              },
              onPanEnd: (DragEndDetails details) {
                setState(() {
                  BlocProvider.of<DoddlerBloc>(context)
                      .add(AddPointEvent(null));
                  // points.add(null);
                });
              },
              //
              child: ClipRect(
                child: CustomPaint(
                  painter:
                      Sketcher(state.points ?? [], kCanvasSize, 10),
                  size: Size(kCanvasSize.width / 2, kCanvasSize.height / 2),
                  willChange: true,
                  isComplex: true,
                  child: const SizedBox.expand(),
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

class Sketcher extends CustomPainter {
  final List<Dot?> points;
  final Size screenSize;
  final double symmetryLines;

  Sketcher(this.points, this.screenSize, this.symmetryLines);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }

  // List<Offset> doS() {
  //   final b = [];
  //   for (final c in points) {
  //     b.add(c?.offset);
  //   }
  //   return [];
  // }

  @override
  void paint(Canvas canvas, Size size) {
    print(size.toString());
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // const symmetryLines = 0;
    var angle = 360 / (symmetryLines);
    
    print(angle);
    Path path = Path();
    for (var j = 0; j < points.length - 1; j++) {
      if (points[j + 1] != null) {
        if (points[j]!.offset != null && points[j + 1]!.offset != null) {
          //Draw Rectangles
          // Rect myRect = Rect.fromLTWH(
          //     points[j]!.offset!.dx, points[j]!.offset!.dy, 3.0, 4.0);

          // canvas.drawRect(myRect, points[j]!.paint ?? paint);

          // Glow Effect
          // canvas.drawLine(
          //     points[j]!.offset!,
          //     points[j + 1]!.offset!,
          //     Paint()
          //       ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0)
          //       ..color = Colors.red.withAlpha(255)
          //       ..strokeWidth = 10.0);

          path.moveTo(points[j]!.offset!.dx, points[j]!.offset!.dy);
          path.lineTo(points[j + 1]!.offset!.dx, points[j + 1]!.offset!.dy);
        }
      } else {
        j++;
      }
    }
    // Rect myRect = const Offset(1.0, 2.0) & const Size(3.0, 4.0);

    for (var i = 0; i <= symmetryLines; i++) {
      // canvas.drawRect(const Offset(1.0, 2.0) & const Size(3.0, 4.0), paint);
      canvas.drawPath(
          path,
          Paint()
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0)
            ..color = Colors.red.withAlpha(255)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10.0);

      canvas.drawPath(path, paint);
      canvas.rotate(angle);
    }

    print("canvas.getSaveCount() = ${canvas.getSaveCount()}");
  }
}
