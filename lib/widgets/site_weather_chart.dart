import 'dart:math';

import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';
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
  late final Color primaryColor = Theme.of(context).brightness == Brightness.light
      ? Colors.white
      : Colors.black;
  final todaysDate = DateTime.now();

  Widget leftTitleWidget(double value, TitleMeta? _) {
    return Text(
      value.toInt().toString(),
      style: TextStyle(
        color: primaryColor,
      ),
    );
  }

  Widget bottomTitleWidget(double value, TitleMeta? _) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.rotate(
        angle: -pi / 4,
        child: Text(
          _dateFromDayIndex(value.toInt()),
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  String _dateFromDayIndex(int index) {
    final thisDate = todaysDate.subtract(Duration(days: widget.data.length - index));
    return DateFormat('M/d').format(thisDate);
  }

  @override
  Widget build(BuildContext context) {
    return PrefVisibility(
      prefKey: '${widget.site.id}_${widget.id}',
      child: Card(
        color: Colors.blueGrey.shade400,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor,
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
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (List<LineBarSpot> spots) {
                            return [
                              LineTooltipItem(
                                '${spots.first.y.toString()}\n${_dateFromDayIndex(spots.first.x.toInt())}',
                                TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ];
                          }
                        )
                      ),
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
                          color: primaryColor,
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
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitleWidget,
                            reservedSize: 40,
                          ),
                        ),
                        rightTitles: AxisTitles(),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(
                        show: false,
                      ),
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