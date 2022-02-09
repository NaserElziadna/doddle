import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:doddle/models/frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:doddle/models/recorder_controller.dart';

import 'recorder_event.dart';
import 'recorder_state.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  RecorderController? recorderController =
      RecorderController(frames: [], globalKey: GlobalKey());
  int index = 0;

  RecorderBloc({this.recorderController}) : super(InitialRecorderState());

  @override
  Stream<RecorderState> mapEventToState(RecorderEvent event) async* {
    if (event is TakeSnapshotEvent) {
      final image = await canvasToImage(event.globalKey!);
      final frames = recorderController!.frames;
      frames!.add(Frame(frame: image, index: index++));
      recorderController = recorderController!.copyWith(frames: frames);
    } else if (event is CallNextFrameEvent) {
      yield NextFrameState(frame: recorderController!.frames![event.index]);
    }
  }

  Future<ui.Image> canvasToImage(GlobalKey globalKey) async {
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage();
    return image;
  }
}
