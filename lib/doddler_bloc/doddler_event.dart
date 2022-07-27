import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:doddle/models/draw_controller.dart';

import '../models/point.dart';

abstract class DoddlerEvent {}

class ClearPointEvent extends DoddlerEvent {
  ClearPointEvent();
}

class AddASceneEvent extends DoddlerEvent {
  AddASceneEvent();
}

class ClearStampsEvent extends DoddlerEvent {
  final bool ok;
  ClearStampsEvent({this.ok = false});
}

class ShareImageEvent extends DoddlerEvent {
  final BuildContext? context;
  final GlobalKey? globalKey;
  ShareImageEvent({this.globalKey, this.context});
}

class AddPointEvent extends DoddlerEvent {
  final Point? point;
  final bool end;
  AddPointEvent({this.point = null, this.end = false});
}

class UndoStampsEvent extends DoddlerEvent {
  UndoStampsEvent();
}

class RedoStampsEvent extends DoddlerEvent {
  RedoStampsEvent();
}

class ChangePenToolEvent extends DoddlerEvent {
  final PenTool penTool;
  ChangePenToolEvent({
    this.penTool = PenTool.glowPen,
  });
}

class ChangePenSizeEvent extends DoddlerEvent {
  final double penSize;
  ChangePenSizeEvent({
    this.penSize = 2,
  });
}

class InitGlobalKeyEvent extends DoddlerEvent {
  GlobalKey globalKey;
  InitGlobalKeyEvent(
    this.globalKey,
  );
}

class TakePageStampEvent extends DoddlerEvent {
  GlobalKey globalKey;
  TakePageStampEvent(
    this.globalKey,
  );
}

class ChangeCurrentColorEvent extends DoddlerEvent {
  final Color? color;
  final bool isRandomColor;
  ChangeCurrentColorEvent(this.color, this.isRandomColor);
}

// class IsRandomColorColorEvent extends DoddlerEvent {
//   final bool isRandomColor;
//   IsRandomColorColorEvent(
//     this.isRandomColor,
//   );
// }

class SavePageToGalleryEvent extends DoddlerEvent {
  final GlobalKey? globalKey;
  SavePageToGalleryEvent({this.globalKey});
}

class UpdateSymmetryLines extends DoddlerEvent {
  final double? symmetryLines;
  UpdateSymmetryLines({this.symmetryLines});
}

class CallNextFrameEvent extends DoddlerEvent {
  CallNextFrameEvent();
}

class MessageEvent extends DoddlerEvent {
  final String message;
  final bool isClear;
  MessageEvent(this.message, {this.isClear = false});
}

class ShowVideoEvent extends DoddlerEvent {
  ShowVideoEvent();
}


// class PanActiveEvent extends DoddlerEvent {
//   final bool isActive;
//   PanActiveEvent(this.isActive);
// }
