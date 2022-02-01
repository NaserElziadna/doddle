import 'package:doddle/draw_controller.dart';

import '../point.dart';

abstract class DoddlerState {}

class InitDoddlerState extends DoddlerState {}

class UpdateCanvasState extends DoddlerState {
  DrawController? drawController;
  UpdateCanvasState({this.drawController});
}