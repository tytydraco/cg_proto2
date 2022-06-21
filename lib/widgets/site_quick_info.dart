import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:cg_proto2/widgets/number_card_widget.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
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
  final remoteDatabase = DemoRemoteDatabase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NumberCardWidget(
              title: 'Temp.',
              text: '${widget.siteWeather.temperature}'
          ),
          NumberCardWidget(
              title: 'Rain.',
              text: '${widget.siteWeather.rainfall}'
          ),
          NumberCardWidget(
              title: 'Soil.',
              text: '${widget.siteWeather.soilMoisture}'
          ),
          NumberCardWidget(
              title: 'Wind Sp.',
              text: '${widget.siteWeather.windSpeed}'
          ),
          NumberCardWidget(
              title: 'Wind Di.',
              text: '${widget.siteWeather.windDirection}'
          ),
        ],
      ),
    );
  }
}