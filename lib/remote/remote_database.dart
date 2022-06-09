import 'dart:math';

import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database_implementation.dart';

/// Offline demo implementation of the remote database using sample data.
class RemoteDatabase implements RemoteDatabaseImplementation {
  @override
  Future<List<SiteModel>> getEntries() async {
    await Future.delayed(const Duration(seconds: 1));
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
  Future<SiteWeatherModel> getCurrentWeather(SiteModel site) async {
    await Future.delayed(const Duration(seconds: 1));
    return SiteWeatherModel(
      temperature: 95,
      humidity: 22,
      rainfall: 0,
      windSpeed: 4,
      windDirection: 0,
      soilMoisture: 25,
    );
  }

  @override
  Future<List<SiteWeatherModel>> getHistoricalWeather(SiteModel site) async {
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    return List.generate(30, (_) {
      return SiteWeatherModel(
        temperature: 90 + random.nextInt(10) + 1,
        humidity: random.nextInt(100) + 1,
        rainfall: random.nextInt(20) + 1,
        windSpeed: random.nextInt(10) + 1,
        windDirection: random.nextInt(4),
        soilMoisture: random.nextInt(100),
      );
    });
  }
}