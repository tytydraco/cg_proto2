import 'package:cg_proto2/data/constants.dart';
import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/database/demo_remote_database.dart';
import 'package:cg_proto2/remote/logic/site_assembler.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:cg_proto2/widgets/site_quick_info.dart';
import 'package:cg_proto2/widgets/chart/site_weather_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final siteAssembler = SiteAssembler();
  final remoteDatabase = DemoRemoteDatabase();

  Future<int> daysToShow() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt('${widget.site.id}_interval') ?? chartIntervalDefault;
  }

  Future<List<SiteWeatherModel>> getHistoricalWeather() async {
    final length = await daysToShow();
    final rawSiteWeathers = await remoteDatabase.getHistoricalWeather(widget.site.id);
    final siteWeathers = siteAssembler.getHistoricalWeather(rawSiteWeathers);
    return siteWeathers.reversed.take(length).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHistoricalWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data as List<SiteWeatherModel>;
          return ListView(
            children: [
              // NOTE: Uses last entry in historical data as current data...
              SiteQuickInfo(
                site: widget.site,
                siteWeather: data.last,
              ),
              SiteWeatherChart(
                id: 'temperature',
                title: 'Temperature',
                site: widget.site,
                getValue: (SiteWeatherModel siteWeather) => siteWeather.temperature!.toDouble(),
                data: data,
              ),
              SiteWeatherChart(
                id: 'wind_speed',
                title: 'Wind Speed',
                site: widget.site,
                getValue: (SiteWeatherModel siteWeather) => siteWeather.windSpeed!.toDouble(),
                data: data,
              ),
              SiteWeatherChart(
                id: 'rainfall',
                title: 'Rainfall',
                site: widget.site,
                getValue: (SiteWeatherModel siteWeather) => siteWeather.rainfall!.toDouble(),
                data: data,
              ),
              SiteWeatherChart(
                id: 'soil_moisture',
                title: 'Soil Moisture',
                site: widget.site,
                getValue: (SiteWeatherModel siteWeather) => siteWeather.soilMoisture!.toDouble(),
                data: data,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text('Cannot fetch site data!');
        } else {
          return const LoadingSpinner();
        }
      },
    );
  }
}
