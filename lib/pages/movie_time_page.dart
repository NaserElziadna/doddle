import 'dart:async';
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<RecorderBloc>().add(SaveGifEvent());
              },
              icon: Icon(Icons.not_started))
        ],
      ),
      body: Center(
        child: BlocBuilder<RecorderBloc, RecorderState>(
          builder: (context, state) {
            if (state is NextFrameState) {
              Future.delayed(Duration(seconds: 1));

              return FutureBuilder(
                future: convertImageToUint8List(state.frame!.frame!),
                builder:
                    (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Text('Please wait its loading...'));
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
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
              // context.read<RecorderBloc>().add(CallNextFrameEvent(index: 0));
              return const CircularProgressIndicator();
            } else if (state is MessageState) {
              return LinearProgressIndicator(
                semanticsLabel: state.message,
              );
            } else if (state is ShowGifState) {
              return Center(
                child: Container(
                  color: Colors.black,
                  child: Image.memory(
                    Uint8List.fromList(state.gif!),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                ),
              );
            }
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }

  Future<Uint8List> convertImageToUint8List(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }
}
