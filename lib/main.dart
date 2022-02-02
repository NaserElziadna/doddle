import 'package:doddle/doddler.dart';
import 'package:doddle/models/draw_controller.dart';
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
    return BlocProvider(
      create: (context) => DoddlerBloc(
        drawController: DrawController(
            points: [], currentColor: Colors.green, symmetryLines: 15),
      ),
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

  @override
  void initState() {
    drawController = context.read<DoddlerBloc>().drawController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.purple[800],
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Slider(
                    value: drawController!.symmetryLines!,
                    max: 30,
                    min: 0,
                    activeColor: Colors.redAccent,
                    label: "S L",
                    thumbColor: Colors.black,
                    inactiveColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        drawController =
                            drawController?.copyWith(symmetryLines: value);
                        context
                            .read<DoddlerBloc>()
                            .add(UpdateSymmetryLines(symmetryLines: value));
                      });
                    },
                  ),
                ),
                // const Spacer(),
                IconButton(
                    tooltip: "share",
                    onPressed: () {
                      BlocProvider.of<DoddlerBloc>(context)
                          .add(ShareImageEvent(context: context));
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    tooltip: "save",
                    onPressed: () {
                      BlocProvider.of<DoddlerBloc>(context)
                          .add(SavePageToGalleryEvent());
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    tooltip: "undo",
                    onPressed: () {
                      BlocProvider.of<DoddlerBloc>(context)
                          .add(UndoStampsEvent());
                    },
                    icon: const Icon(
                      Icons.undo,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    tooltip: "redo",
                    onPressed: () {
                      BlocProvider.of<DoddlerBloc>(context)
                          .add(RedoStampsEvent());
                    },
                    icon: const Icon(
                      Icons.redo,
                      color: Colors.white,
                      size: 30,
                    )),
                IconButton(
                    tooltip: "clear",
                    onPressed: () {
                      BlocProvider.of<DoddlerBloc>(context)
                          .add(ClearStampsEvent());
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 30,
                    )),
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
