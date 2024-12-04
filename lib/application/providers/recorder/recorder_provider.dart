import 'dart:typed_data';
import 'package:doddle/domain/models/recorder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screen_recorder/screen_recorder.dart';

final recorderControllerProvider = Provider((ref) => ScreenRecorderController());

final recordingStateProvider = StateNotifierProvider<RecordingStateNotifier, RecordingState>((ref) {
  return RecordingStateNotifier(ref.watch(recorderControllerProvider));
});

class RecordingStateNotifier extends StateNotifier<RecordingState> {
  final ScreenRecorderController controller;

  RecordingStateNotifier(this.controller) : super(const RecordingState());

  void startRecording() {
    controller.start();
    state = state.copyWith(isRecording: true);
  }

  void stopRecording() {
    controller.stop();
    state = state.copyWith(
      isRecording: false,
      hasFrames: controller.exporter.hasFrames,
    );
  }

  Future<void> exportAsGif(BuildContext context) async {
    state = state.copyWith(isExporting: true);
    
    try {
      final gif = await controller.exporter.exportGif();
      if (gif != null) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Image.memory(Uint8List.fromList(gif)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement save functionality
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        }
      }
    } finally {
      state = state.copyWith(isExporting: false);
    }
  }

  void clearRecording() {
    controller.exporter.clear();
    state = state.copyWith(hasFrames: false);
  }
}
