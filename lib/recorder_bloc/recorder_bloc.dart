import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:doddle/models/frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:doddle/models/recorder_controller.dart';
import 'package:screen_recorder/screen_recorder.dart';

import '../doddler.dart';
import 'recorder_event.dart';
import 'recorder_state.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  ScreenRecorderController? recorderController;
  List<int>? old_gif = [];

  RecorderBloc({this.recorderController}) : super(InitialRecorderState());

  @override
  Stream<RecorderState> mapEventToState(RecorderEvent event) async* {
    if (event is StartRecordingEvent) {
      recorderController!.start();
      yield RecordState(RecordStatus.startRecording);
    } else if (event is PrepareVideoPageEvent) {
      print(old_gif);
      recorderController!.stop();
      yield RecordState(RecordStatus.prepareVideo);
      List<int>? gif = await recorderController!.export();

      yield RecordState(RecordStatus.donePreparingVideo,
          obg: gif!.followedBy(old_gif ?? []).toList());
      old_gif = gif.followedBy(old_gif ?? []).toList();
    }
  }
}
