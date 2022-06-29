import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/widgets/site_weather_stat.dart';
import 'package:flutter/material.dart';

/// A row that displays the current sensor data for a specific site.
class SiteQuickInfo extends StatefulWidget {
  final SiteModel site;
  final SiteWeatherModel siteWeather;

  const SiteQuickInfo({
    Key? key,
    required this.site,
    required this.siteWeather,
  }) : super(key: key);

  @override
  State<SiteQuickInfo> createState() => _SiteQuickInfoState();
}

class _SiteQuickInfoState extends State<SiteQuickInfo> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SiteWeatherStat(
              title: 'Temperature',
              text: '${widget.siteWeather.temperature}',
              unit: '°F',
            ),
            SiteWeatherStat(
              title: 'Rainfall',
              text: '${widget.siteWeather.rainfall}',
              unit: 'mm',
            ),
            SiteWeatherStat(
              title: 'Soil moisture',
              text: '${widget.siteWeather.soilMoisture}',
              unit: '%',
            ),
            SiteWeatherStat(
              title: 'Wind speed',
              text: '${widget.siteWeather.windSpeed}',
              unit: 'm/s',
            ),
            SiteWeatherStat(
              title: 'Wind direction',
              text: '${widget.siteWeather.windDirection}',
            ),
          ],
        ),
      ),
    );
  }
}