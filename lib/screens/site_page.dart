import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/screens/settings_page.dart';
import 'package:cg_proto2/widgets/site_quick_info.dart';
import 'package:cg_proto2/widgets/site_weather_chart.dart';
import 'package:flutter/material.dart';

/// Displays relevant information about a particular site.
class SitePage extends StatefulWidget {
  const SitePage({Key? key, required this.site}) : super(key: key);

  final SiteModel site;

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.site.id),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(site: widget.site)),
              ).whenComplete(() => setState(() {}));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
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
      ),
    );
  }
}