import 'dart:math';
import 'package:doddle/application/providers/router/router_provider.dart';
import 'package:doddle/presentation/painting/guidelines_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_recorder/screen_recorder.dart';
import '../../../generated/assets.gen.dart';
import '../../../domain/models/draw_controller.dart';
import '../../../domain/models/point.dart';
import '../../painting/last_image_as_background.dart';
import '../../painting/sketcher.dart';
import '../../common/utils/single_gesture_recognizer.dart';
import '../../common/widgets/tools/tools_widget.dart';
import '../../../application/providers/canvas/canvas_provider.dart';
import '../../../application/providers/recorder/recorder_provider.dart';
import '../../../presentation/common/widgets/recording/recording_controls.dart';

class CanvasScreen extends ConsumerStatefulWidget {
  static GlobalKey? globalKey = GlobalKey();

  const CanvasScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends ConsumerState<CanvasScreen> {
  static Size kCanvasSize = Size.zero;
  // late bool ignorePointer;
  // late int pointerCount;

  @override
  void initState() {
    super.initState();
    // ignorePointer = false;
    // pointerCount = 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(canvasNotifierProvider.notifier).initializeEffects();
      ref
          .read(canvasNotifierProvider.notifier)
          .setGlobalKey(CanvasScreen.globalKey!);
    });
  }

  @override
  Widget build(BuildContext context) { 

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.purple[800],
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.save_alt_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () => ref
                          .read(canvasNotifierProvider.notifier)
                          .saveToGallery(CanvasScreen.globalKey!),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () => context.pushNamed(RouteNames.aboutMe.name),
                    ),
                    if (!kIsWeb)
                      GestureDetector(
                        child: Assets.svg.share.svg(width: 40),
                        onTap: () => ref
                            .read(canvasNotifierProvider.notifier)
                            .shareImage(CanvasScreen.globalKey!, context),
                      ),
                    const Spacer(),
                    GestureDetector(
                      child: Assets.svg.undo.svg(width: 40),
                      onTap: () =>
                          ref.read(canvasNotifierProvider.notifier).undoStamp(),
                    ),
                    GestureDetector(
                      child: Assets.svg.redo.svg(width: 40),
                      onTap: () =>
                          ref.read(canvasNotifierProvider.notifier).redoStamp(),
                    ),
                    const Spacer(),
                    GestureDetector(
                      child: Assets.svg.close.svg(width: 40),
                      onTap: () => _showClearConfirmation(context),
                    ),
                  ],
                ),
                const RecordingControls(),
              ],
            ),
          ),
        ),
        body: _buildCanvas(),
        bottomSheet: const ToolsWidget(),
      ),
    );
  }

  Widget _buildCanvas() {
    final drawController = ref.watch(canvasNotifierProvider);

    return Container(
      color: Colors.purple[800],
      child: InteractiveViewer(
        panEnabled: false,
        scaleEnabled: true,
        minScale: 0.1,
        maxScale: 5,
        boundaryMargin: const EdgeInsets.all(80),
        onInteractionEnd: _handleInteractionEnd,
        onInteractionUpdate: _handleInteractionUpdate,
        onInteractionStart: _handleInteractionStart,
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 150,
            left: 20,
            right: 20,
            top: 100,
          ),
          color: Colors.black,
          child: _buildGestureDetector(drawController),
        ),
      ),
    );
  }

  void _handleGestureStart(PointerEvent pointerEvent) {
    if (ref.read(canvasNotifierProvider).isPanActive) return;
    // if (ignorePointer == false && pointerCount == 1) {
    if (ref.read(canvasNotifierProvider).isRandomColor) {
      final random = Random();
      final color = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      ref.read(canvasNotifierProvider.notifier).changeColor(color, true);
    }
    // }
  }

  void _handleGestureUpdate(PointerEvent pointerEvent) {
    if (ref.read(canvasNotifierProvider).isPanActive) return;
    // if (ignorePointer == false && pointerCount == 1) {
    setState(() {
      kCanvasSize = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - (AppBar().preferredSize.height),
      );
      var pinSpaceX = -20;
      var pinSpaceY = -160;

      Offset point = pointerEvent.localPosition;
      point = point.translate(
        -((kCanvasSize.width / 2) + pinSpaceX),
        -((kCanvasSize.height / 2) + pinSpaceY),
      );

      ref.read(canvasNotifierProvider.notifier).addPoint(Point(offset: point));
    });
    // }
  }

  void _handleGestureEnd(PointerEvent pointerEvent) {
    // if (ref.read(canvasNotifierProvider).isPanActive) return;
    // if (ignorePointer == false && pointerCount == 1) {
    setState(() {
      kCanvasSize = Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - (AppBar().preferredSize.height),
      );
      var pinSpaceX = -20;
      var pinSpaceY = -160;

      Offset point = pointerEvent.localPosition;
      point = point.translate(
        -((kCanvasSize.width / 2) + pinSpaceX),
        -((kCanvasSize.height / 2) + pinSpaceY),
      );

      ref.read(canvasNotifierProvider.notifier).addPoint(
            Point(offset: point),
            end: true,
          );
    });
    // }
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Canvas'),
        content: const Text(
            'This will clear the canvas. Are you sure you want to continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(canvasNotifierProvider.notifier).clearStamps();
              Navigator.pop(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _handleInteractionEnd(ScaleEndDetails details) {
    print('pan end ${details.pointerCount}');
    ref.read(canvasNotifierProvider.notifier).setPanActive(false);
    // setState(() {
    //   ignorePointer = details.pointerCount > 1;
    //   pointerCount = 1;
    // });
  }

  void _handleInteractionUpdate(ScaleUpdateDetails details) {
    print('pan update ${details.pointerCount}');
    if (details.pointerCount > 1) {
      //clear last point
      ref.read(canvasNotifierProvider.notifier).clearPoints();
    }
    // setState(() {
    //   ignorePointer = details.pointerCount > 1;
    //   pointerCount = details.pointerCount;
    // });
  }

  void _handleInteractionStart(ScaleStartDetails details) {
    if (details.pointerCount > 1) {
      print('pan active ${details.pointerCount}');
      ref.read(canvasNotifierProvider.notifier).setPanActive(true);
      //clear last point
      ref.read(canvasNotifierProvider.notifier).clearPoints();
    }
    // setState(() {
    //   ignorePointer = details.pointerCount > 1;
    //   pointerCount = details.pointerCount;
    // });
  }

  Widget _buildGestureDetector(DrawController drawController) {
    return Consumer(
      builder: (context, ref, child) {
        final drawController = ref.watch(canvasNotifierProvider);
        return IgnorePointer(
          ignoring: drawController.isPanActive,
          child: RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            gestures: <Type, GestureRecognizerFactory>{
              SingleGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<SingleGestureRecognizer>(
                () => SingleGestureRecognizer(debugOwner: this),
                (instance) {
                  instance.onStart = _handleGestureStart;
                  instance.onUpdate = _handleGestureUpdate;
                  instance.onEnd = _handleGestureEnd;
                },
              ),
            },
            //add the guidelines layer in stack under the r
            child: Stack(children: [
              RepaintBoundary(
                key: CanvasScreen.globalKey,
                child: ClipRect(
                  child: ScreenRecorder(
                    background: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    controller: ref.read(recorderControllerProvider),
                    child: CustomPaint(
                      foregroundPainter: Sketcher(
                        drawController,
                        ref,
                      ),
                      painter: LastImageAsBackground(
                        image: drawController.stamp?.isEmpty ?? true
                            ? null
                            : drawController.stamp?.last?.image,
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
              // Guidelines Layer (always on top)
              CustomPaint(
                painter: GuidelinesPainter(
                  symmetryLines: drawController.symmetryLines ?? 5,
                  penSize: 10,
                  showGuidelines: drawController.showGuidelines ,
                  isMirror: drawController.mirrorSymmetry ,
                ),
                child: Container(),
              ),
            ]),
          ),
        );
      },
    );
  }
}
