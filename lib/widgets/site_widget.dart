import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/screens/site.dart';
import 'package:flutter/material.dart';

class SiteWidget extends StatelessWidget {
  final SiteModel site;

  const SiteWidget({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(site.displayName)
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SitePage(site: site))
          );
        },
      ),
    );
  }
}
