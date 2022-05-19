import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SiteWeatherChart extends StatefulWidget {
  final String id;
  final String title;
  final num Function(SiteWeatherModel) yFn;
  final List<SiteWeatherModel> Function(List<SiteWeatherModel>)? filterFn;

  const SiteWeatherChart({
    Key? key,
    required this.id,
    required this.title,
    required this.yFn,
    this.filterFn,
  }) : super(key: key);

  @override
  State<SiteWeatherChart> createState() => _SiteWeatherChartState();
}

class _SiteWeatherChartState extends State<SiteWeatherChart> {
  final remoteDatabase = RemoteDatabase();

  Future<List<SiteWeatherModel>> getAllSiteWeathers() async {
    final sites = await remoteDatabase.getEntries();
    final List<SiteWeatherModel> siteWeathers = [];
    for (var site in sites) {
      siteWeathers.add(await remoteDatabase.getWeather(site));
    }

    if (widget.filterFn != null) {
      return widget.filterFn!(siteWeathers);
    }

    return siteWeathers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllSiteWeathers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final siteWeathers = snapshot.data as List<SiteWeatherModel>;
          final List<charts.Series<SiteWeatherModel, num>> series = [
            charts.Series(
              id: widget.id,
              data: siteWeathers,
              domainFn: (SiteWeatherModel siteWeather, int? index) => index!,
              measureFn: (SiteWeatherModel siteWeather, _) => widget.yFn(siteWeather),
            )
          ];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(widget.title),
                  SizedBox(
                    height: 200,
                    child: charts.LineChart(
                      series,
                      animate: true,
                    ),
                  ),
                ],
              )
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Failed to fetch weather data!');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}