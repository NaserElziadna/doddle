import 'package:doddle/doddler_bloc/doddler_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
                onPressed: () {
                  // final globalKey = BlocProvider.of<DoddlerBloc>(context)
                  //     .drawController!
                  //     .globalKey;
                  BlocProvider.of<DoddlerBloc>(context)
                      .add(SavePageToGalleryEvent());
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {
                  BlocProvider.of<DoddlerBloc>(context).add(UndoStampsEvent());
                },
                icon: const Icon(
                  Icons.undo,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {
                  ColorPicker(
                    pickerColor: Colors.red,
                    onColorChanged: (color) {
                      BlocProvider.of<DoddlerBloc>(context)
                          .add(ChangeCurrentColorEvent(color));
                    },
                  );
                },
                icon: const Icon(
                  Icons.color_lens,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {
                   BlocProvider.of<DoddlerBloc>(context).add(RedoStampsEvent());
                },
                icon: const Icon(
                  Icons.redo,
                  color: Colors.white,
                  size: 36,
                )),
            IconButton(
                onPressed: () {
                  BlocProvider.of<DoddlerBloc>(context).add(ClearStampsEvent());
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
