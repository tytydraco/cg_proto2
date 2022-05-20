import 'package:cg_proto2/models/site_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreference schema is {site.id}_{id} of type bool
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
  Future<bool> getChecked() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('${widget.site.id}_${widget.id}') ?? true;
  }

  Future setChecked(bool newValue) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setBool('${widget.site.id}_${widget.id}', newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Text(widget.title),
            ),
            FutureBuilder(
              future: getChecked(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final checked = snapshot.data as bool;
                  return Checkbox(
                    value: checked,
                    onChanged: (newValue) {
                      setChecked(newValue!);
                      setState(() {});
                    }
                  );
                } else if (snapshot.hasError) {
                  return const Icon(Icons.warning);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
