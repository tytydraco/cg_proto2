import 'package:flutter/material.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A checkbox that determines whether or not we save previously-authenticated credentials.
class LoginSaveCheckbox extends StatefulWidget {
  const LoginSaveCheckbox({Key? key}) : super(key: key);

  @override
  State<LoginSaveCheckbox> createState() => _LoginSaveCheckboxState();
}

class _LoginSaveCheckboxState extends State<LoginSaveCheckbox> {
  Future<bool> _getChecked() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('save_credentials') ?? false;
  }

  Future _setChecked(bool newState) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool('save_credentials', newState);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: false,
      future: _getChecked(),
      builder: (context, snapshot) {
        final checked = snapshot.data as bool;
        if (snapshot.hasData) {
          return CheckboxListTile(
            title: const Text('Save credentials'),
            value: checked,
            onChanged: (state) {
              _setChecked(state!);
              setState(() {});
            }
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
