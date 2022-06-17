import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/screens/settings_page.dart';
import 'package:cg_proto2/widgets/site_all_data_list.dart';
import 'package:flutter/material.dart';

/// Displays relevant information about a particular site.
class SitePage extends StatefulWidget {
  const SitePage({Key? key, required this.site}) : super(key: key);

  final SiteModel site;

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.site.id),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage(site: widget.site)),
              ).whenComplete(() => setState(() {}));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SiteAllDataList(site: widget.site),
    );
  }
}