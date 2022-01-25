import '../dot.dart';

abstract class DoddlerEvent {}

class ClearPageEvent extends DoddlerEvent {
  ClearPageEvent();
}

class AddPointEvent extends DoddlerEvent {
  final Dot? dot;
  AddPointEvent(this.dot);
}

class UndoPointEvent extends DoddlerEvent {
  UndoPointEvent();
}

class RedoPointEvent extends DoddlerEvent {
  RedoPointEvent();
}
