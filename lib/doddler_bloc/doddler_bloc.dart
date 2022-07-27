import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:doddle/models/draw_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

import 'doddler_event.dart';
import 'doddler_state.dart';

class DoddlerBloc extends Bloc<DoddlerEvent, DoddlerState> {
  DrawController? drawController;
  var index = 0;

  DoddlerBloc({this.drawController}) : super(UpdateCanvasState());

  @override
  Stream<DoddlerState> mapEventToState(DoddlerEvent event) async* {
    if (event is ClearPointEvent) {
      drawController!.points!.clear();
      yield UpdateCanvasState(drawController: drawController);
    } else if (event is ClearStampsEvent) {
      if (event.ok) {
        if (drawController!.stamp!.isEmpty) {
          return;
        }
        drawController!.stamp!.clear();
        yield UpdateCanvasState(drawController: drawController);
      }
    } else if (event is AddPointEvent) {
      if (drawController!.isPanActive) {
        drawController!.points!.add(event.point);
        if (event.end) {
          add(TakePageStampEvent(drawController!.globalKey!));
          // add(AddASceneEvent());
        }
        yield UpdateCanvasState(drawController: drawController);
      }
    } else if (event is UndoStampsEvent) {
      if (drawController!.stamp!.isNotEmpty) {
        List<Stamp?>? stamps = List.from(drawController!.stamp!);
        final undoS = stamps.removeLast();

        List<Stamp?>? undoStamps = List.from(drawController!.stampUndo!);
        undoStamps.add(undoS);
        drawController =
            drawController!.copyWith(stamp: stamps, stampUndo: undoStamps);

        yield UpdateCanvasState(drawController: drawController);
      }
    } else if (event is RedoStampsEvent) {
      if (drawController!.stampUndo!.isNotEmpty) {
        List<Stamp?>? stampUndo = List.from(drawController!.stampUndo!);
        final toRedo = stampUndo.removeLast();

        List<Stamp?>? stamps = List.from(drawController!.stamp!);
        stamps.add(toRedo);

        drawController = drawController!.copyWith(
          stamp: stamps,
          stampUndo: stampUndo,
        );

        yield UpdateCanvasState(drawController: drawController);
      }
    } else if (event is ChangeCurrentColorEvent) {
      drawController = drawController?.copyWith(
        currentColor: event.color,
        isRandomColor: event.isRandomColor,
      );
      yield UpdateCanvasState(drawController: drawController);
    } else if (event is ChangePenToolEvent) {
      drawController = drawController?.copyWith(penTool: event.penTool);
      yield UpdateCanvasState(drawController: drawController);
    } else if (event is SavePageToGalleryEvent) {
      save(event.globalKey ?? drawController!.globalKey!);
    } else if (event is InitGlobalKeyEvent) {
      drawController = drawController?.copyWith(globalKey: event.globalKey);
      // drawController!.globalKey = event.globalKey;
    } else if (event is UpdateSymmetryLines) {
      drawController =
          drawController?.copyWith(symmetryLines: event.symmetryLines);
      // drawController!.globalKey = event.globalKey;
    } else if (event is TakePageStampEvent) {
      try {
        ui.Image image = await canvasToImage(event.globalKey);
        List<Stamp?>? stamps = List.from(drawController!.stamp!);
        stamps.add(Stamp(image: image));
        drawController = drawController!.copyWith(stamp: stamps);

        add(ClearPointEvent());
      } catch (e) {
        yield MessageState(e.toString());
      }
      yield UpdateCanvasState(drawController: drawController);
    } else if (event is ShareImageEvent) {
      try {
        screenShotAndShare(
            event.globalKey ?? drawController!.globalKey!, event.context!);
      } catch (e) {
        yield MessageState(e.toString());
      }
      // yield UpdateCanvasState(drawController: drawController);
    } else if (event is MessageEvent) {
      yield MessageState(event.message, isClear: event.isClear);
      yield UpdateCanvasState(drawController: drawController);
    } else if (event is ShowVideoEvent) {
      yield ShowRecordState();
    } else if (event is ChangePenSizeEvent) {
      drawController!.copyWith(
        penSize: event.penSize,
      );
      yield UpdateCanvasState(drawController: drawController);
    }
    //  else if (event is PanActiveEvent) {
    //   drawController = drawController!.copyWith(isPanActive: event.isActive);
    //   yield UpdateCanvasState(drawController: drawController);
    // }
  }

  Future<ui.Image> canvasToImage(GlobalKey globalKey) async {
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage();
    return image;
  }

  Future<void> save(GlobalKey globalKey) async {
    try {
      final boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final saved = await ImageGallerySaver.saveImage(
        pngBytes,
        quality: 100,
        name: DateTime.now().toIso8601String() + ".jpeg",
        isReturnImagePathOfIOS: true,
      );
      add(MessageEvent("Image Saved To Gallery ♥"));
    } catch (e) {
      add(MessageEvent(e.toString()));
    }
  }

  Future<Null> screenShotAndShare(
      GlobalKey globalKey, BuildContext context) async {
    try {
      print("Phase 1" * 200);
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory())?.path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      print("Phase 2" * 200);

      File imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print('Screenshot Path:' + imgFile.path);

      print("Phase 3" * 200);
      final RenderBox box = context.findRenderObject() as RenderBox;
      Share.shareFiles(['$directory/screenshot.png'],
          subject: 'Doddle App',
          text: 'Hey, check it out My Amazing Doddle!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      print("Phase 4" * 200);
    } catch (e) {
      add(MessageEvent(e.toString()));
    }
  }
}
