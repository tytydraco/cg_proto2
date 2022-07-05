import 'package:flutter/material.dart';

class SiteWeatherStat extends StatelessWidget {
  final String title;
  final String text;
  final String? unit;

  final _textColor = Colors.white;

  const SiteWeatherStat({
    Key? key,
    required this.title,
    required this.text,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentText = unit == null ? text : '$text $unit';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: _textColor,
            ),
          ),
          Text(
            contentText,
            style: TextStyle(
              fontSize: 16,
              color: _textColor,
            ),
          ),
        ],
      ),
    );
  }
}