import 'package:doddle/doddler.dart';
import 'package:doddle/draw_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_event.dart';
import 'tools_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double symmetryLines = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoddlerBloc(
        drawController: DrawController(
            points: [], currentColor: Colors.white, symmetryLines: 15),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(
          color: Colors.purple[700],
          child: Doddler(),
        ),
      ),
    );
  }
}
