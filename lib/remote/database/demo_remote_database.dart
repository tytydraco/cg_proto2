import 'dart:math';

import 'package:artificial_delay/artificial_delay.dart';
import 'package:cg_proto2/remote/database/remote_database_implementation.dart';

/// Offline demo implementation of the remote database using sample data.
class DemoRemoteDatabase implements RemoteDatabaseImplementation {
  final _artificialDelay = ArtificialDelay(
    minDelay: const Duration(milliseconds: 100),
    maxDelay: const Duration(milliseconds: 1000),
  );

  @override
  Future<List<Map<String, dynamic>>> getEntries() async {
    await _artificialDelay.trigger();
    return List.generate(20, (index) => {
      'name': 'Site ${index + 1}'
    });
  }

  @override
  Future<Map<String, dynamic>> getCurrentWeather(String siteName) async {
    await _artificialDelay.trigger();
    return {
      'temperature': 95,
      'humidity': 22,
      'rainfall': 0,
      'windSpeed': 4,
      'windDirection': 0,
      'soilMoisture': 25,
    };
  }

  @override
  Future<List<Map<String, dynamic>>> getHistoricalWeather(String siteName) async {
    await _artificialDelay.trigger();
    final random = Random();
    return List.generate(30, (_) {
      return {
        'temperature': 90 + random.nextInt(10) + 1,
        'humidity': random.nextInt(100) + 1,
        'rainfall': random.nextInt(20) + 1,
        'windSpeed': random.nextInt(10) + 1,
        'windDirection': random.nextInt(4),
        'soilMoisture': random.nextInt(100),
      };
    });
  }
}