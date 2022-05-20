import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/widgets/chart_interval_dropdown.dart';
import 'package:cg_proto2/widgets/chart_visibility_checkbox.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final SiteModel site;

  const SettingsPage({Key? key, required this.site}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Site Settings'),
      ),
      body: ListView(
        children: [
          ChartIntervalDropDown(site: widget.site),
          ChartVisibilityCheckbox(
            site: widget.site,
            id: 'temperature',
            title: 'Temperature'
          ),
          ChartVisibilityCheckbox(
            site: widget.site,
            id: 'wind_speed',
            title: 'Wind Speed'
          ),
          ChartVisibilityCheckbox(
            site: widget.site,
            id: 'rainfall',
            title: 'Rainfall'
          ),
          ChartVisibilityCheckbox(
            site: widget.site,
            id: 'soil_moisture',
            title: 'Soil Moisture'
          ),
        ],
      ),
    );
  }
}