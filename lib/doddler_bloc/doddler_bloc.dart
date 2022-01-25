import 'package:bloc/bloc.dart';

import '../dot.dart';
import 'doddler_event.dart';
import 'doddler_state.dart';

class DoddlerBloc extends Bloc<DoddlerEvent, DoddlerState> {
  List<Dot?>? points = [];
  DoddlerBloc({this.points}) : super(PagePointsState());

  @override
  Stream<DoddlerState> mapEventToState(DoddlerEvent event) async* {
    if (event is ClearPageEvent) {
      points!.clear();
      yield PagePointsState(points: points);
    } else if (event is AddPointEvent) {
      points!.add(event.dot);
      yield PagePointsState(points: points);
    }else if(event is UndoPointEvent){

    }
    else if(event is RedoPointEvent){

    }
  }
}
