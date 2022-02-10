import 'package:doddle/models/frame.dart';

abstract class RecorderState {}

class InitialRecorderState extends RecorderState {}

class NextFrameState extends RecorderState {
  final Frame? frame;
  NextFrameState({
    this.frame,
  });
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
