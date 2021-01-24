import 'package:equatable/equatable.dart';
import 'package:flutter_radio/model/station.dart';

class RadioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayEvent extends RadioEvent {
  final Station station;

  PlayEvent(this.station);

  @override
  List<Object> get props => [station];
}

class PauseEvent extends RadioEvent {
  @override
  List<Object> get props => [];
}