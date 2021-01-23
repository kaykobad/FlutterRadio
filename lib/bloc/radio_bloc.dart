import 'package:bloc/bloc.dart';
import 'package:flutter_radio/bloc/radio_event.dart';
import 'package:flutter_radio/bloc/radio_state.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  RadioBloc(RadioState initialState) : super(initialState);

  @override
  Stream<RadioState> mapEventToState(RadioEvent event) async* {
    if (event is PlayEvent && state is! PlayingState) {
      yield PlayingState();
    } else if (event is PauseEvent) {
      yield PausedState();
    }
  }

}