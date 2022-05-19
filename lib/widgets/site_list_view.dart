import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/remote/remote_database.dart';
import 'package:flutter/material.dart';

class SiteListView extends StatefulWidget {
  const SiteListView({Key? key}) : super(key: key);

  @override
  State<SiteListView> createState() => _SiteListViewState();
}

class _SiteListViewState extends State<SiteListView> {
  final remoteDatabase = RemoteDatabase();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: remoteDatabase.getEntries(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final siteList = snapshot.data as List<SiteModel>;
          return ListView.builder(
            itemCount: siteList.length,
            itemBuilder: (context, index) {
              final site = siteList[index];
              return Text('ID: ${site.id}; NAME: ${site.displayName}');
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Failed to fetch site list!');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
