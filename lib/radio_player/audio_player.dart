import 'package:flutter_radio/radio_player/radio_player.dart';
import 'package:just_audio/just_audio.dart';

class JustAudioPlayer extends RadioPlayer {
  final audioPlayer = AudioPlayer();
  var _isUrlSet = false;

  @override
  Future<void> pause() {
    return audioPlayer.pause();
  }

  @override
  Future<void> play({String url}) async {
    if (!_isUrlSet) {
      await audioPlayer.setUrl(url);
      _isUrlSet = true;
    }
    return audioPlayer.play();
  }

}