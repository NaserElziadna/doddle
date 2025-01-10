import 'package:freezed_annotation/freezed_annotation.dart';

part 'recorder_state.freezed.dart';

@freezed
class RecordingState with _$RecordingState {
  const factory RecordingState({
    @Default(false) bool isRecording,
    @Default(false) bool isExporting,
    @Default(false) bool hasFrames,
  }) = _RecordingState;
}
