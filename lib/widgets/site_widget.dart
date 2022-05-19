import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/screens/site_page.dart';
import 'package:flutter/material.dart';

class SiteWidget extends StatelessWidget {
  final SiteModel site;

  const SiteWidget({Key? key, required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(site.id)
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
