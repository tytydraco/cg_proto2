import 'package:cg_proto2/models/site_model.dart';
import 'package:flutter/material.dart';

class SiteWidget extends StatefulWidget {
  final SiteModel site;

  const SiteWidget({Key? key, required this.site}) : super(key: key);

  @override
  State<SiteWidget> createState() => _SiteWidgetState();
}

class _SiteWidgetState extends State<SiteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(widget.site.displayName)
        ),
        onTap: () {
          // TODO: navigate to SitePage
        },
      ),
    );
  }
}
