import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';

class SiteQuickInfo extends StatefulWidget {
  final SiteModel site;

  const SiteQuickInfo({Key? key, required this.site}) : super(key: key);

  @override
  State<SiteQuickInfo> createState() => _SiteQuickInfoState();
}

class _PaddedNumCard extends StatelessWidget {
  final String title;
  final String text;

  const _PaddedNumCard({Key? key, required this.title, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: Text(text)
            ),
          ),
        ),
        Text(title),
      ],
    );
  }
}

class _SiteQuickInfoState extends State<SiteQuickInfo> {
  final remoteDatabase = RemoteDatabase();

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
                _PaddedNumCard(
                  title: 'Temp.',
                  text: '${siteWeather.temperature}'
                ),
                _PaddedNumCard(
                  title: 'Rain.',
                  text: '${siteWeather.rainfall}'
                ),
                _PaddedNumCard(
                  title: 'Soil.',
                  text: '${siteWeather.soilMoisture}'
                ),
                _PaddedNumCard(
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