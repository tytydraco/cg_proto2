import 'package:cg_proto2/remote/database/demo_remote_database.dart';
import 'package:cg_proto2/remote/logic/site_assembler.dart';
import 'package:cg_proto2/widgets/site_widget.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';

/// A list of clickable sites.
class SiteListView extends StatefulWidget {
  const SiteListView({Key? key}) : super(key: key);

  @override
  State<SiteListView> createState() => _SiteListViewState();
}

class _SiteListViewState extends State<SiteListView> {
  final _siteAssembler = SiteAssembler();
  final _remoteDatabase = DemoRemoteDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _remoteDatabase.getEntries(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final rawSiteList = snapshot.data as List<Map<String, dynamic>>;
          final siteList = _siteAssembler.getEntries(rawSiteList);
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: siteList.length,
            itemBuilder: (context, index) {
              final site = siteList[index];
              return SiteWidget(site: site);
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Failed to fetch site list!');
        } else {
          return const LoadingSpinner();
        }
      },
    );
  }
}
