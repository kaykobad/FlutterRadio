import 'package:bloc/bloc.dart';
import 'package:flutter_radio/bloc/radio_event.dart';
import 'package:flutter_radio/bloc/radio_state.dart';
import 'package:flutter_radio/radio_player/radio_player.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  final RadioPlayer radioPlayer;

  RadioBloc(RadioState initialState, this.radioPlayer) : super(initialState);

  @override
  Stream<RadioState> mapEventToState(RadioEvent event) async* {
    if (event is PlayEvent && state is! PlayingState) {
      radioPlayer.play(url: event.url);
      yield PlayingState();
    } else if (event is PauseEvent) {
      radioPlayer.pause();
      yield PausedState();
    }
  }

}