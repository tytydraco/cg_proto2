import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';

/// Abstract class to handle remote database actions such as
/// fetching site information
abstract class RemoteDatabaseImplementation {
  /// Returns a list of SiteModels from the live database
  Future<List<SiteModel>> getEntries();

  /// Returns WeatherModel given a SiteModel
  Future<SiteWeatherModel> getWeather(SiteModel site);
}