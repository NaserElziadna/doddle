import 'package:doddle/models/draw_controller.dart';

import '../models/point.dart';

abstract class DoddlerState {}

class InitDoddlerState extends DoddlerState {}

class UpdateCanvasState extends DoddlerState {
  DrawController? drawController;
  UpdateCanvasState({this.drawController});
}

class GetNextFrameState extends DoddlerState {
  final Frame? frame;
  GetNextFrameState({this.frame});
}

class MessageState extends DoddlerState {
  final String message;
  final bool isClear;
  MessageState(this.message, {this.isClear = false});
}
