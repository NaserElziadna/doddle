import 'dart:async';

import 'package:doddle/doddler.dart';
import 'package:doddle/generated/assets.gen.dart';
import 'package:doddle/models/draw_controller.dart';
import 'package:doddle/models/recorder_controller.dart';
import 'package:doddle/pages/about_me_page.dart';
import 'package:doddle/recorder_bloc/recorder_bloc.dart';
import 'package:doddle/recorder_bloc/recorder_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doddler_bloc/doddler_bloc.dart';
import 'doddler_bloc/doddler_event.dart';
import 'widgets/tools_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]); // To turn off landscape mode
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DoddlerBloc(
            drawController: DrawController(
                isPanActive: true,
                penTool: PenTool.glowPen,
                points: [],
                currentColor: Colors.green,
                symmetryLines: 0),
          ),
        ),
        BlocProvider(
          create: (context) => RecorderBloc(
            recorderController: RecorderController(
              frames: [],
              globalKey: GlobalKey(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawController? drawController;
  Timer? timer;

  @override
  void initState() {
    drawController = context.read<DoddlerBloc>().drawController;
    context.read<RecorderBloc>().add(StartRecordingEvent());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.purple[800],
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.save_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(SavePageToGalleryEvent());
                  },
                ),
                GestureDetector(
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builder) {
                      return const AboutMePage();
                    }));
                  },
                ),
                GestureDetector(
                  child: Assets.svg.share.svg(width: 40),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(ShareImageEvent(context: context));
                  },
                ),
                const Spacer(),
                GestureDetector(
                  child: Assets.svg.undo.svg(width: 40),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(UndoStampsEvent());
                  },
                ),
                GestureDetector(
                  child: Assets.svg.redo.svg(width: 40),
                  onTap: () {
                    BlocProvider.of<DoddlerBloc>(context)
                        .add(RedoStampsEvent());
                  },
                ),
                const Spacer(),
                GestureDetector(
                  child: Assets.svg.close.svg(width: 40),
                  onTap: () {
                    // BlocProvider.of<DoddlerBloc>(context)
                    //     .add(ClearStampsEvent());

                    context.read<DoddlerBloc>().add(MessageEvent(
                        "This will case to clear the canvas ,\n are you sure you want to Continue ? ",
                        isClear: true));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.purple[800],
          child: const Doddler(),
        ),
        bottomSheet: const ToolsWidget(),
      ),
    );
  }
}
