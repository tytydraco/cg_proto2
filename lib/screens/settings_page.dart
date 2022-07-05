import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/widgets/chart/chart_interval_dropdown.dart';
import 'package:cg_proto2/widgets/chart/chart_visibility_checkbox.dart';
import 'package:flutter/material.dart';

/// Displays site-specific settings.
class SettingsPage extends StatelessWidget {
  final SiteModel site;

  const SettingsPage({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Site Settings'),
      ),
      body: ListView(
        children: [
          ChartIntervalDropDown(site: site),
          ChartVisibilityCheckbox(
              site: site,
              id: 'temperature',
              title: 'Temperature'
          ),
          ChartVisibilityCheckbox(
              site: site,
              id: 'wind_speed',
              title: 'Wind Speed'
          ),
          ChartVisibilityCheckbox(
              site: site,
              id: 'rainfall',
              title: 'Rainfall'
          ),
          ChartVisibilityCheckbox(
              site: site,
              id: 'soil_moisture',
              title: 'Soil Moisture'
          ),
        ],
      ),
    );
  }
}
