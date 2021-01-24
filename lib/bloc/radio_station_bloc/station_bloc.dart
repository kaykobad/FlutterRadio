import 'package:bloc/bloc.dart';
import 'package:flutter_radio/model/station.dart';
import 'package:flutter_radio/repository/radio_station_repository.dart';

import 'station_event.dart';
import 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final StationRepository stationRepository;
  final int _pageSize = 15;
  final String _countryCode = 'au';

  StationBloc(StationState initialState, this.stationRepository) : super(initialState);

  @override
  Stream<StationState> mapEventToState(StationEvent event) async* {
    if (event is FetchStationsEvent) {
      yield (LoadingStationsState());
      try {
        final List<Station> stations = await stationRepository.getStationsByCountryPaginated(_countryCode, 0, _pageSize);
        yield StationsFetchedState(
          stations: stations,
          stationPageIndex: 0,
          hasFetchedAll: false,
        );
      } catch (err) {
        yield StationsFetchErrorState();
      }
    } else if (event is FetchNextStationsEvent && state is StationsFetchedState) {
      final currentState = (state as StationsFetchedState);
      final int index = currentState.stationPageIndex + _pageSize;
      final List<Station> oldStations = currentState.stations;
      yield FetchingNextStationsState();
      try {
        final List<Station> stations =
        await stationRepository.getStationsByCountryPaginated(_countryCode, index, _pageSize);
        yield StationsFetchedState(
          stations: oldStations..addAll(stations),
          stationPageIndex: index,
          hasFetchedAll: (stations.length < _pageSize) ? true : false,
        );
      } catch (err) {
        yield StationsFetchErrorState();
      }
    }
  }
}