import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/widgets/pref_visibility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A chart to display historical sensor data for a particular site.
class SiteWeatherChart extends StatefulWidget {
  final String id;
  final String title;
  final SiteModel site;
  final double Function(SiteWeatherModel) yFn;
  final List<SiteWeatherModel> data;

  const SiteWeatherChart({
    Key? key,
    required this.id,
    required this.title,
    required this.site,
    required this.yFn,
    required this.data,
  }) : super(key: key);

  @override
  State<SiteWeatherChart> createState() => _SiteWeatherChartState();
}

class _SiteWeatherChartState extends State<SiteWeatherChart> {
  Widget leftTitleWidget(double value, TitleMeta? _) {
    return Text(value.toInt().toString());
  }

  @override
  Widget build(BuildContext context) {
    final lineColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return PrefVisibility(
      prefKey: '${widget.site.id}_${widget.id}',
      child: Card(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
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
                          spots: widget.data.asMap().entries.map((entry) {
                            final index = entry.key;
                            final siteWeather = entry.value;
                            return FlSpot(index.toDouble(), widget.yFn(siteWeather));
                          }).toList(),
                          dotData: FlDotData(show: false),
                          isCurved: true,
                          isStrokeCapRound: true,
                          barWidth: 3,
                          belowBarData: BarAreaData(show: false),
                          color: lineColor,
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
          ),
        ),
      )
    );
  }
}