import 'package:equatable/equatable.dart';
import '../../model/station.dart';

class RadioState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayingState extends RadioState {
  final Station currentStation;

  PlayingState(this.currentStation);

  @override
  List<Object> get props => [currentStation];
}

class PausedState extends RadioState {
  final Station currentStation;

  PausedState(this.currentStation);

  @override
  List<Object> get props => [currentStation];
}

class StoppedState extends RadioState {
  @override
  List<Object> get props => [];
}