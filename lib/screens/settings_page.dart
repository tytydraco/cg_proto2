import 'package:cg_proto2/models/site_model.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final SiteModel site;

  const SettingsPage({Key? key, required this.site}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Site Settings'),
      ),
      body: Center(),
    );
  }
}