import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';

/// Business logic to process raw database data
/// Converts raw data from database into data models
class SiteAssembler {
  List<SiteModel> getEntries(List<Map<String, dynamic>> entries) {
    return entries.map((e) => SiteModel(e['name'] as String)).toList();
  }

  SiteWeatherModel getCurrentWeather(Map<String, dynamic> currentWeather) {
    // TODO: int or int?
    String? windDirectionStr;
    switch(currentWeather['windDirection'] as int) {
      case 0:
        windDirectionStr = 'North';
        break;
      case 1:
        windDirectionStr = 'East';
        break;
      case 2:
        windDirectionStr = 'South';
        break;
      case 3:
        windDirectionStr = 'West';
        break;
    }

    return SiteWeatherModel(
      temperature: currentWeather['temperature'] as int,
      humidity: currentWeather['humidity'] as int,
      rainfall: currentWeather['rainfall'] as int,
      windSpeed: currentWeather['windSpeed'] as int,
      windDirection: windDirectionStr,
      soilMoisture: currentWeather['soilMoisture'] as int,
    );
  }

  List<SiteWeatherModel> getHistoricalWeather(List<Map<String, dynamic>> historicalWeather) {
    return historicalWeather.map((e) => getCurrentWeather(e)).toList();
  }
}