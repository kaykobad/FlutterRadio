import 'package:equatable/equatable.dart';
import '../../model/station.dart';

class StationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends StationState {
  @override
  List<Object> get props => [];
}

class LoadingStationsState extends StationState {
  @override
  List<Object> get props => [];
}

class FetchingNextStationsState extends StationState {
  @override
  List<Object> get props => [];
}

class StationsFetchedState extends StationState {
  final List<Station> stations;
  final int stationPageIndex;
  final bool hasFetchedAll;

  StationsFetchedState({
    this.stations,
    this.stationPageIndex,
    this.hasFetchedAll,
  });

  @override
  List<Object> get props => [];
}

class StationsFetchErrorState extends StationState {
  @override
  List<Object> get props => [];
}