import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/widgets/site_quick_info.dart';
import 'package:cg_proto2/widgets/site_weather_chart.dart';
import 'package:flutter/material.dart';

class SitePage extends StatefulWidget {
  const SitePage({Key? key, required this.site}) : super(key: key);

  final SiteModel site;

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.site.id),
      ),
      body: ListView(
        children: [
          SiteQuickInfo(site: widget.site),
          SiteWeatherChart(
            id: 'temperature',
            title: 'Temperature',
            site: widget.site,
            yFn: (SiteWeatherModel siteWeather) => siteWeather.temperature!,
          ),
        ],
      ),
    );
  }
}