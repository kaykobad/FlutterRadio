import 'current_radio_state.dart';

abstract class RadioPlayer {
  Stream<CurrentRadioState> radioStateStream;

  Future<void> setUrl(String url);
  Future<void> play();
  Future<void> pause();
}