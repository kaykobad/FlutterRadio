import 'dart:async';

import 'package:flutter_radio/radio_player/current_radio_state.dart';
import 'package:flutter_radio/radio_player/radio_player.dart';
import 'package:just_audio/just_audio.dart';

class JustAudioPlayer extends RadioPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Stream<CurrentRadioState> currentRadioStateStream;

  JustAudioPlayer() {
    currentRadioStateStream = _audioPlayer.playbackStateStream.map(_mapToCurrentRadioState);
  }

  @override
  Future<void> setUrl(String url) async {
    return _audioPlayer.setUrl(url);
  }

  @override
  Future<void> play() async {
    return _audioPlayer.play();
  }

  @override
  Future<void> pause() {
    return _audioPlayer.pause();
  }

  CurrentRadioState _mapToCurrentRadioState(AudioPlaybackState audioState) {
    switch (audioState) {
      case AudioPlaybackState.none:
      case AudioPlaybackState.stopped:
        return CurrentRadioState.STOPPED;
      case AudioPlaybackState.paused:
        return CurrentRadioState.PAUSED;
      case AudioPlaybackState.playing:
        return CurrentRadioState.PLAYING;
      default:
        return CurrentRadioState.UNKNOWN;
    }
  }
}