import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:cg_proto2/widgets/pref_visibility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
  final remoteDatabase = RemoteDatabase();

  Future<List<SiteWeatherModel>> getHistoricalWeatherFiltered() async {
    final siteWeathers = await remoteDatabase.getHistoricalWeather(widget.site);

    if (widget.filterFn != null) {
      return widget.filterFn!(siteWeathers);
    }

    return siteWeathers;
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
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}