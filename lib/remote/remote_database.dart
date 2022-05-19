import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database_implementation.dart';

/// Actual implementation of RemoteDatabase
/// TODO: connect this to live database
class RemoteDatabase implements RemoteDatabaseImplementation {
  @override
  Future<List<SiteModel>> getEntries() async {
    return [
      SiteModel('Site 1'),
      SiteModel('Site 2'),
      SiteModel('Site 3'),
      SiteModel('Site 4'),
      SiteModel('Site 5'),
      SiteModel('Site 6'),
      SiteModel('Site 7'),
      SiteModel('Site 8'),
      SiteModel('Site 9'),
      SiteModel('Site 10'),
      SiteModel('Site 11'),
    ];
  }

  @override
  Future<SiteWeatherModel> getWeather(SiteModel site) async {
    return SiteWeatherModel(
      temperature: 95,
      humidity: 22,
      rainfall: 0,
      windSpeed: 4,
      windDirection: 0,
    );
  }
}