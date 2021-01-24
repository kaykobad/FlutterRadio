import '../bloc/radio_player_bloc/radio_state.dart';

abstract class RadioPlayer {
  Stream<RadioState> radioStateStream;

  Future<void> setUrl(String url);
  Future<void> play();
  Future<void> pause();
}