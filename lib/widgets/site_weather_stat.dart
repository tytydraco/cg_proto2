import 'package:flutter/material.dart';

class SiteWeatherStat extends StatelessWidget {
  final String title;
  final String text;
  final String? unit;

  const SiteWeatherStat({
    Key? key,
    required this.title,
    required this.text,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.light ?
        Colors.white :
        Colors.black;
    final contentText = unit == null ? text : '$text $unit';
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            contentText,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}