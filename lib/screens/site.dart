import 'package:flutter/material.dart';

class SitePage extends StatefulWidget {
  const SitePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SitePage> createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
    );
  }
}