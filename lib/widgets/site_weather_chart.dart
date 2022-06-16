import 'package:cg_proto2/data/constants.dart';
import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:cg_proto2/widgets/pref_visibility.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A chart to display historical sensor data for a particular site.
class SiteWeatherChart extends StatefulWidget {
  final String id;
  final String title;
  final SiteModel site;
  final double Function(SiteWeatherModel) yFn;
  final List<SiteWeatherModel> Function(List<SiteWeatherModel>)? filterFn;

  const SiteWeatherChart({
    Key? key,
    required this.id,
    required this.title,
    required this.site,
    required this.yFn,
    this.filterFn,
  }) : super(key: key);

  @override
  State<SiteWeatherChart> createState() => _SiteWeatherChartState();
}

class _SiteWeatherChartState extends State<SiteWeatherChart> {
  final remoteDatabase = DemoRemoteDatabase();

  Future<int> daysToShow() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt('${widget.site.id}_interval') ?? chartIntervalDefault;
  }

  Future<List<SiteWeatherModel>> getHistoricalWeatherFiltered() async {
    final length = await daysToShow();
    final siteWeathers = await remoteDatabase.getHistoricalWeather(widget.site);
    final reducedSiteWeathers = siteWeathers.reversed.take(length).toList();

    if (widget.filterFn != null) {
      return widget.filterFn!(reducedSiteWeathers);
    }

    return reducedSiteWeathers;
  }

  Widget leftTitleWidget(double value, TitleMeta? _) {
    return Text(value.toInt().toString());
  }

  @override
  Widget build(BuildContext context) {
    return PrefVisibility(
      prefKey: '${widget.site.id}_${widget.id}',
      child: FutureBuilder(
        future: getHistoricalWeatherFiltered(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final siteWeathers = snapshot.data as List<SiteWeatherModel>;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: AspectRatio(
                    aspectRatio: 2.5,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: siteWeathers.asMap().entries.map((entry) {
                              final index = entry.key;
                              final siteWeather = entry.value;
                              return FlSpot(index.toDouble(), widget.yFn(siteWeather));
                            }).toList(),
                            dotData: FlDotData(show: false),
                            isCurved: true,
                            isStrokeCapRound: true,
                            barWidth: 3,
                            belowBarData: BarAreaData(show: false),
                            color: Colors.black,
                          ),
                        ],
                        titlesData: FlTitlesData(
                          topTitles: AxisTitles(),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: leftTitleWidget,
                              reservedSize: 40,
                            ),
                          ),
                          bottomTitles: AxisTitles(),
                          rightTitles: AxisTitles(),
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('Failed to fetch weather data!');
          } else {
            return const LoadingSpinner();
          }
        },
      ),
    );
  }
}