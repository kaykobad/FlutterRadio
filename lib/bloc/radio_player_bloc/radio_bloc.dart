import 'package:bloc/bloc.dart';
import 'package:flutter_radio/bloc/radio_player_bloc/radio_event.dart';
import 'package:flutter_radio/bloc/radio_player_bloc/radio_state.dart';
import 'package:flutter_radio/radio_player/current_radio_state.dart';
import 'package:flutter_radio/radio_player/radio_player.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  final RadioPlayer radioPlayer;

  RadioBloc(RadioState initialState, this.radioPlayer) : super(initialState) {
    radioPlayer.radioStateStream.listen((radioState) {
      if (radioState == CurrentRadioState.PLAYING && state is PausedState) {
        this.add(PlayEvent((state as PausedState).currentStation));
      }
    });
  }

  @override
  Stream<RadioState> mapEventToState(RadioEvent event) async* {
    if (event is PlayEvent) {
      yield* _handlePlayEvent(event);
    } else if (event is PauseEvent) {
      yield* _handlePauseEvent(event);
    }
  }

  Stream<RadioState> _handlePlayEvent(PlayEvent playEvent) async* {
    if (state is StoppedState) {
      _playNewRadioStation(playEvent);
      yield PlayingState(playEvent.station);
    } else if (state is PausedState) {
      if ((state as PausedState).currentStation != playEvent.station) {
        _playNewRadioStation(playEvent);
      } else {
        _playExistingRadioStation();
      }
      yield PlayingState(playEvent.station);
    } else if (state is PlayingState) {
      if ((state as PlayingState).currentStation != playEvent.station) {
        _playNewRadioStation(playEvent);
      } else {
        _playExistingRadioStation();
      }
      yield PlayingState(playEvent.station);
    }
  }

  Stream<RadioState> _handlePauseEvent(PauseEvent pauseEvent) async* {
    if (state is PlayingState) {
      radioPlayer.pause();
      yield PausedState((state as PlayingState).currentStation);
    }
  }

  void _playExistingRadioStation() {
    radioPlayer.play();
  }

  void _playNewRadioStation(PlayEvent playEvent) {
    radioPlayer.setUrl(playEvent.station.radioUrl).then((_) {
      radioPlayer.play();
    });
  }

}