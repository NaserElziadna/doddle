import 'dart:ui';

import 'package:doddle/models/draw_controller.dart';
import 'package:flutter/cupertino.dart';

import '../models/point.dart';

abstract class DoddlerEvent {}

class ClearPointEvent extends DoddlerEvent {
  ClearPointEvent();
}

class AddASceneEvent extends DoddlerEvent {
  AddASceneEvent();
}

class ClearStampsEvent extends DoddlerEvent {
  ClearStampsEvent();
}

class ShareImageEvent extends DoddlerEvent {
  final BuildContext? context;
  final GlobalKey? globalKey;
  ShareImageEvent({this.globalKey, this.context});
}

class AddPointEvent extends DoddlerEvent {
  final Point? point;
  final bool end;
  AddPointEvent(this.point, {this.end = false});
}

class UndoStampsEvent extends DoddlerEvent {
  UndoStampsEvent();
}

class RedoStampsEvent extends DoddlerEvent {
  RedoStampsEvent();
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
  ChangeCurrentColorEvent(this.color);
}

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