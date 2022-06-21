import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';

/// Abstract class to handle remote database interactions.
abstract class RemoteDatabaseImplementation {
  /// Returns a list of SiteModels from the live database.
  Future<List<SiteModel>> getEntries();

  /// Returns the most recent WeatherModel given a SiteModel.
  Future<SiteWeatherModel> getCurrentWeather(SiteModel site);

  /// Returns all prior WeatherModels given a SiteModel.
  Future<List<SiteWeatherModel>> getHistoricalWeather(SiteModel site);
}