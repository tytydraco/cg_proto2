import 'package:cg_proto2/screens/home_page.dart';
import 'package:cg_proto2/widgets/login_error_text.dart';
import 'package:cg_proto2/widgets/custom_login_widget.dart';
import 'package:flutter/material.dart';

/// Displays username and password authentication dialog.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Is true if the user failed to login.
  bool hadError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginErrorText(show: hadError),
            CustomLoginWidget(
              onSuccess: () {
                hadError = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ).whenComplete(() => setState(() {}));
              },
              onFailed: () {
                setState(() => hadError = true);
              },
            ),
          ]
        )
      ),
    );
  }
}
