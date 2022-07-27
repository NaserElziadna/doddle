import 'package:flutter/cupertino.dart';

abstract class RecorderEvent {}

class StartRecordingEvent extends RecorderEvent {}

class StopRecordingEvent extends RecorderEvent {}

class PlayVideoEvent extends RecorderEvent {}

class StopVideoEvent extends RecorderEvent {}

class SaveGifEvent extends RecorderEvent {}

class PrepareVideoPageEvent extends RecorderEvent {
  
}

class CallNextFrameEvent extends RecorderEvent {
  final int index;
  CallNextFrameEvent({
    required this.index,
  });
}
