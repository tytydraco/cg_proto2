import 'dart:math';

import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
import 'package:cg_proto2/widgets/chart/chart_title.dart';
import 'package:cg_proto2/widgets/pref_visibility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final todayDate = DateTime.now();

  Widget _leftTitleWidget(double value, TitleMeta? _) {
    return Text(
      value.toInt().toString(),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _bottomTitleWidget(double value, TitleMeta? _) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.rotate(
        angle: -pi / 4,
        child: Text(
          _dateFromDayIndex(value.toInt()),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String _dateFromDayIndex(int index) {
    final thisDate = todayDate.subtract(Duration(days: widget.data.length - index));
    return DateFormat('M/d').format(thisDate);
  }

  List<FlSpot> _getSpotsFromData() {
    return widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final siteWeather = entry.value;
      return FlSpot(index.toDouble(), widget.yFn(siteWeather));
    }).toList();
  }

  LineTooltipItem _getTooltipItemForSpot(FlSpot spot) {
    final dateStr = _dateFromDayIndex(spot.x.toInt());
    return LineTooltipItem(
      '${spot.y.toInt().toString()}\n$dateStr',
      const TextStyle(
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrefVisibility(
      prefKey: '${widget.site.id}_${widget.id}',
      child: Card(
        color: Colors.blueGrey.shade400,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChartTitle(title: widget.title),
            Padding(
              padding: const EdgeInsets.all(18),
              child: AspectRatio(
                aspectRatio: 2.5,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getSpotsFromData(),
                        dotData: FlDotData(show: false),
                        isCurved: true,
                        isStrokeCapRound: true,
                        barWidth: 3,
                        belowBarData: BarAreaData(show: false),
                        color: Colors.white,
                      ),
                    ],
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(),
                      rightTitles: AxisTitles(),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: _leftTitleWidget,
                          reservedSize: 40,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: _bottomTitleWidget,
                          reservedSize: 40,
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (List<LineBarSpot> spots) =>
                            [ _getTooltipItemForSpot(spots.first) ]
                        )
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}