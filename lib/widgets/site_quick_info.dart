import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:flutter/material.dart';

class SiteQuickInfo extends StatefulWidget {
  final SiteModel site;

  const SiteQuickInfo({Key? key, required this.site}) : super(key: key);

  @override
  State<SiteQuickInfo> createState() => _SiteQuickInfoState();
}

class _SiteQuickInfoState extends State<SiteQuickInfo> {
  final remoteDatabase = RemoteDatabase();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: FutureBuilder(
          future: remoteDatabase.getWeather(widget.site),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final siteWeather = snapshot.data as SiteWeatherModel;
              return Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${siteWeather.temperature}"),
                    Text("${siteWeather.rainfall}"),
                    Text("${siteWeather.soilMoisture}"),
                    Text("${siteWeather.humidity}"),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Failed to fetch weather data!');
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
    );
  }
}