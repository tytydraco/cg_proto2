import 'package:flutter/material.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A container to show or hide a widget based on a SharedPreference boolean.
class PrefVisibility extends StatefulWidget {
  final String prefKey;
  final Widget child;

  const PrefVisibility({
    Key? key,
    required this.prefKey,
    required this.child,
  }) : super(key: key);

  @override
  State<PrefVisibility> createState() => _PrefVisibilityState();
}

class _PrefVisibilityState extends State<PrefVisibility> {
  Future<bool> isVisible() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(widget.prefKey) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isVisible(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isVisible = snapshot.data as bool;
          return Visibility(
            visible: isVisible,
            child: widget.child,
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.warning);
        } else {
          return const LoadingSpinner();
        }
      },
    );
  }
}
