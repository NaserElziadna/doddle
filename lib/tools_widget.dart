import 'package:doddle/doddler_bloc/doddler_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doddler_bloc/doddler_bloc.dart';

class ToolsWidget extends StatefulWidget {
  const ToolsWidget({Key? key}) : super(key: key);

  @override
  _ToolsWidgetState createState() => _ToolsWidgetState();
}

class _ToolsWidgetState extends State<ToolsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoddlerBloc(),
      child: Container(
        height: MediaQuery.of(context).size.height * .1,
        color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.undo,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.redo,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {
                  BlocProvider.of<DoddlerBloc>(context).add(ClearPageEvent());
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.brush,
                  color: Colors.white,
                  size: 36,
                )),
          ],
        ),
      ),
    );
  }
}
