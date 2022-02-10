import 'dart:async';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:doddle/models/frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:doddle/models/recorder_controller.dart';

import '../doddler.dart';
import 'recorder_event.dart';
import 'recorder_state.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  RecorderController? recorderController =
      RecorderController(frames: [], globalKey: GlobalKey());
  int index = 0;
  bool isRecording = false;
  int recordingIndex = 0;
  Timer? timer;

  RecorderBloc({this.recorderController}) : super(InitialRecorderState());

  @override
  Stream<RecorderState> mapEventToState(RecorderEvent event) async* {
    if (event is TakeSnapshotEvent) {
      if (!isRecording) {
        timer =
            Timer.periodic(const Duration(milliseconds: 34), (Timer t) async {
          final frames = recorderController!.frames;

          final image = await canvasToImage(event.globalKey!);
          frames!.add(Frame(frame: image, index: index++));
          recorderController = recorderController!.copyWith(frames: frames);
        });
      }
    } else if (event is SaveGifEvent) {
      add(StopRecordingEvent());
      yield MessageState("Waiting ... ");
      final gif = await recorderController!.export();
      yield ShowGifState(gif: gif);
    } else if (event is StartRecordingEvent) {
      add(TakeSnapshotEvent(globalKey: Doddler.globalKey));
    } else if (event is StopRecordingEvent) {
      timer!.cancel();
    }
  }

  Future<ui.Image> canvasToImage(GlobalKey globalKey) async {
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final image = await boundary.toImage();
    return image;
  }
}
