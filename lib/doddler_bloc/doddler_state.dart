import 'package:doddle/models/draw_controller.dart';

import '../models/point.dart';

abstract class DoddlerState {}

class InitDoddlerState extends DoddlerState {}

class ShowRecordState extends DoddlerState {}

class UpdateCanvasState extends DoddlerState {
  DrawController? drawController;
  UpdateCanvasState({this.drawController});
}


class MessageState extends DoddlerState {
  final String message;
  final bool isClear;
  MessageState(this.message, {this.isClear = false});
}

class ChangeSliderValueState extends DoddlerState {
  final double penSize;

  ChangeSliderValueState({this.penSize = 1});
}
