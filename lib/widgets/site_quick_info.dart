import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:cg_proto2/widgets/number_card_widget.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';

/// A row that displays the current sensor data for a specific site.
class SiteQuickInfo extends StatefulWidget {
  final SiteModel site;

  const SiteQuickInfo({Key? key, required this.site}) : super(key: key);

  @override
  State<SiteQuickInfo> createState() => _SiteQuickInfoState();
}

class _SiteQuickInfoState extends State<SiteQuickInfo> {
  final remoteDatabase = DemoRemoteDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: remoteDatabase.getCurrentWeather(widget.site),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final siteWeather = snapshot.data as SiteWeatherModel;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberCardWidget(
                  title: 'Temp.',
                  text: '${siteWeather.temperature}'
                ),
                NumberCardWidget(
                  title: 'Rain.',
                  text: '${siteWeather.rainfall}'
                ),
                NumberCardWidget(
                  title: 'Soil.',
                  text: '${siteWeather.soilMoisture}'
                ),
                NumberCardWidget(
                  title: 'Humi.',
                  text: '${siteWeather.humidity}'
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Failed to fetch weather data!');
        } else {
          return const LoadingSpinner();
        }
      },
    );
  }
}