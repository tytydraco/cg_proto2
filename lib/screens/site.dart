import 'package:cg_proto2/models/site_model.dart';
import 'package:flutter/material.dart';

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
        title: Text(widget.site.displayName),
      ),
      body: Center(),
    );
  }
}