import '../dot.dart';

abstract class DoddlerState {}

class InitDoddlerState extends DoddlerState {}

class PagePointsState extends DoddlerState {
  List<Dot?>? points = [];
  PagePointsState({this.points});
}