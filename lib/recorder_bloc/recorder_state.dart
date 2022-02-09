import 'package:doddle/models/frame.dart';

abstract class RecorderState {}

class InitialRecorderState extends RecorderState {}

class NextFrameState extends RecorderState {
  final Frame? frame;
  NextFrameState({
    this.frame,
  });
}
