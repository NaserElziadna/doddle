import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers/recorder/recorder_provider.dart';

class RecordingControls extends ConsumerWidget {
  const RecordingControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingStateProvider);

    if (recordingState.isExporting) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!recordingState.isRecording)
          IconButton(
            icon: const Icon(Icons.fiber_manual_record, color: Colors.red),
            onPressed: () => ref.read(recordingStateProvider.notifier).startRecording(),
          )
        else
          IconButton(
            icon: const Icon(Icons.stop, color: Colors.white),
            onPressed: () => ref.read(recordingStateProvider.notifier).stopRecording(),
          ),
        if (recordingState.hasFrames) ...[
          IconButton(
            icon: const Icon(Icons.gif, color: Colors.white),
            onPressed: () => ref.read(recordingStateProvider.notifier).exportAsGif(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => ref.read(recordingStateProvider.notifier).clearRecording(),
          ),
        ],
      ],
    );
  }
}
