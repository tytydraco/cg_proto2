import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A checkbox that determines the visibility of a chart.
/// SharedPreference schema is {site.id}_{id} of type bool.
class ChartVisibilityCheckbox extends StatefulWidget {
  final SiteModel site;
  final String id;
  final String title;

  const ChartVisibilityCheckbox({
    Key? key,
    required this.site,
    required this.id,
    required this.title
  }) : super(key: key);

  @override
  State<ChartVisibilityCheckbox> createState() => _ChartVisibilityCheckboxState();
}

class _ChartVisibilityCheckboxState extends State<ChartVisibilityCheckbox> {
  Future<bool> _getChecked() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('${widget.site.id}_${widget.id}') ?? true;
  }

  Future _setChecked(bool newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setBool('${widget.site.id}_${widget.id}', newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: _getChecked(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final checked = snapshot.data as bool;
              return CheckboxListTile(
                title: Text(widget.title),
                value: checked,
                onChanged: (newValue) {
                  _setChecked(newValue!);
                  setState(() {});
                }
              );
            } else if (snapshot.hasError) {
              return const Icon(Icons.warning);
            } else {
              return const LoadingSpinner();
            }
          },
        ),
      ),
    );
  }
}
