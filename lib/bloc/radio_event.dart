import 'package:equatable/equatable.dart';

class RadioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayEvent extends RadioEvent {
  final String url;

  PlayEvent(this.url) : assert(url != null);

  @override
  List<Object> get props => [url];
}

class PauseEvent extends RadioEvent {
  @override
  List<Object> get props => [];
}