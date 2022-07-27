import 'package:doddle/models/frame.dart';

enum RecordStatus {
  none,
  prepareVideo,
  donePreparingVideo,
  stopRecording,
  startRecording,
  stopPlaying,
  startPlaying
}

abstract class RecorderState {}

class InitialRecorderState extends RecorderState {}

class RecordState extends RecorderState {
  RecordStatus record;
  Object? obg;
  RecordState(this.record,{this.obg});
}

class MessageState extends RecorderState {
  final String message;

  MessageState(this.message);
}

class ShowGifState extends RecorderState {
  final gif;
  ShowGifState({
    this.gif,
  });
}
