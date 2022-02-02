import 'dart:math';

import 'package:doddle/doddler_bloc/doddler_bloc.dart';
import 'package:doddle/doddler_bloc/doddler_event.dart';
import 'package:doddle/doddler_bloc/doddler_state.dart';
import 'package:doddle/painting/recorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanvasMoviePage extends StatefulWidget {
  const CanvasMoviePage({Key? key}) : super(key: key);

  @override
  _CanvasMoviePageState createState() => _CanvasMoviePageState();
}

class _CanvasMoviePageState extends State<CanvasMoviePage> {
  @override
  void initState() {
    context.read<DoddlerBloc>().add(CallNextFrameEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Time"),
        backwardsCompatibility: true,
      ),
      body: Center(
        child: BlocConsumer<DoddlerBloc, DoddlerState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetNextFrameState) {
              return CustomPaint(
                foregroundPainter: Recorder(frame: state.frame!),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(Random().nextInt(255),
                    Random().nextInt(255), Random().nextInt(255), 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
