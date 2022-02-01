import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../point.dart';

abstract class DoddlerEvent {}

class ClearPointEvent extends DoddlerEvent {
  ClearPointEvent();
}

class ClearStampsEvent extends DoddlerEvent {
  ClearStampsEvent();
}

class AddPointEvent extends DoddlerEvent {
  final Point? point;
  AddPointEvent(this.point);
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
