import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:doddle/recorder_bloc/recorder_bloc.dart';
import 'package:doddle/recorder_bloc/recorder_event.dart';
import 'package:doddle/recorder_bloc/recorder_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieTimePage extends StatefulWidget {
  const MovieTimePage({Key? key}) : super(key: key);

  @override
  MovieTimePageState createState() => MovieTimePageState();
}

class MovieTimePageState extends State<MovieTimePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecorderBloc(),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<RecorderBloc, RecorderState>(
            builder: (context, state) {
              if (state is NextFrameState) {
                return FutureBuilder(
                  future: convertImageToUint8List(state.frame!.frame!),
                  builder: (BuildContext context,
                      AsyncSnapshot<Uint8List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        context.read<RecorderBloc>().add(
                            CallNextFrameEvent(index: state.frame!.index! + 1));

                        return Center(
                          child: Image.memory(
                            snapshot.data!,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                          ),
                        );
                      } // snapshot.data  :- get your object which is pass from your downloadData() function
                    }
                  },
                );
              } else if (state is InitialRecorderState) {
                context.read<RecorderBloc>().add(CallNextFrameEvent(index: 0));
                return const CircularProgressIndicator();
              }
              return const CircularProgressIndicator(
                color: Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<Uint8List> convertImageToUint8List(ui.Image image) {
    return Future.value();
  }
}
