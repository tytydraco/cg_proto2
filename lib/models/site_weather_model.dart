/// A data structure that stores the sensor information for a specific site.
class SiteWeatherModel {
  final int? temperature;
  final int? windSpeed;
  final int? windDirection;
  final int? rainfall;
  final int? soilMoisture;
  final int? humidity;
  final int? altitude;
  final int? pressure;
  final int? uv;

  SiteWeatherModel({
    this.temperature,
    this.windSpeed,
    this.windDirection,
    this.rainfall,
    this.soilMoisture,
    this.humidity,
    this.altitude,
    this.pressure,
    this.uv
  });
}