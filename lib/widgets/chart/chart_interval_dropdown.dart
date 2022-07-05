import 'package:cg_proto2/data/constants.dart';
import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A drop-down list of valid chart history intervals.
/// The SharedPreference schema is {site.id}_interval of type int.
class ChartIntervalDropDown extends StatefulWidget {
  final SiteModel site;

  const ChartIntervalDropDown({
    Key? key,
    required this.site,
  }) : super(key: key);

  @override
  State<ChartIntervalDropDown> createState() => _ChartIntervalDropDownState();
}

class _ChartIntervalDropDownState extends State<ChartIntervalDropDown> {
  Future<int> _getInterval() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt('${widget.site.id}_interval') ?? chartIntervalDefault;
  }

  Future _setInterval(int newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setInt('${widget.site.id}_interval', newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Expanded(
              child: Text('Chart interval'),
            ),
            FutureBuilder(
              future: _getInterval(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final interval = snapshot.data as int;
                  return DropdownButton<int>(
                    value: interval,
                    items: chartIntervals.map((interval) =>
                      DropdownMenuItem<int>(
                        value: interval,
                        child: Text(interval.toString()),
                      )
                    ).toList(),
                    onChanged: (newValue) {
                      _setInterval(newValue as int);
                      setState(() {});
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Icon(Icons.warning);
                } else {
                  return const LoadingSpinner();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
