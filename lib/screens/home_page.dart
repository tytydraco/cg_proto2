import 'package:cg_proto2/widgets/site_list_view.dart';
import 'package:flutter/material.dart';

/// Displays the list of all sites.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Gardens'),
      ),
      body: const Center(
        child: SiteListView()
      ),
    );
  }
}