import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../point.dart';

abstract class DoddlerEvent {}

class ClearPageEvent extends DoddlerEvent {
  ClearPageEvent();
}

class AddPointEvent extends DoddlerEvent {
  final Point? point;
  AddPointEvent(this.point);
}

class UndoPointEvent extends DoddlerEvent {
  UndoPointEvent();
}

class RedoPointEvent extends DoddlerEvent {
  RedoPointEvent();
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
