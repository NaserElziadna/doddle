import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/recorder/recorder_provider.dart';

class PreviewScreen extends ConsumerWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recorder = ref.watch(recorderControllerProvider);
    final recordingState = ref.watch(recordingStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recording Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement sharing functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Implement saving functionality
            },
          ),
        ],
      ),
      // body: Center(
      //   child: !recordingState.hasFrames
      //       ? const Text('No recording available')
      //       : AnimatedBuilder(
      //           animation: ValueNotifier<int>(0),
      //           builder: (context, child) {
      //             return recorder.exporter.frames.isEmpty 
      //               ? const Text('No frames available')
      //               : Image(
      //                   image: MemoryImage(recorder.),
      //                   fit: BoxFit.contain,
      //                 );
      //           },
      //         ),
      // ),
      
    );
  }
}
