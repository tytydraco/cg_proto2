import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/widgets/site_quick_info.dart';
import 'package:cg_proto2/widgets/site_weather_chart.dart';
import 'package:flutter/material.dart';

class SiteAllDataList extends StatefulWidget {
  final SiteModel site;

  const SiteAllDataList({
    Key? key,
    required this.site,
  }) : super(key: key);

  @override
  State<SiteAllDataList> createState() => _SiteAllDataListState();
}

class _SiteAllDataListState extends State<SiteAllDataList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SiteQuickInfo(site: widget.site),
        SiteWeatherChart(
          id: 'temperature',
          title: 'Temperature',
          site: widget.site,
          yFn: (SiteWeatherModel siteWeather) => siteWeather.temperature!.toDouble(),
        ),
        SiteWeatherChart(
          id: 'wind_speed',
          title: 'Wind Speed',
          site: widget.site,
          yFn: (SiteWeatherModel siteWeather) => siteWeather.windSpeed!.toDouble(),
        ),
        SiteWeatherChart(
          id: 'rainfall',
          title: 'Rainfall',
          site: widget.site,
          yFn: (SiteWeatherModel siteWeather) => siteWeather.rainfall!.toDouble(),
        ),
        SiteWeatherChart(
          id: 'soil_moisture',
          title: 'Soil Moisture',
          site: widget.site,
          yFn: (SiteWeatherModel siteWeather) => siteWeather.soilMoisture!.toDouble(),
        ),
      ],
    );
  }
}
