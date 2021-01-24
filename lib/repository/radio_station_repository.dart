import '../model/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStationsByCountryPaginated(String country, int offset, int limit);
}