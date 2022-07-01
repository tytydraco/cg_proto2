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
            CustomLoginWidget(
              onSuccess: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ).whenComplete(() => setState(() {}));
              },
            ),
          ]
        )
      ),
    );
  }
}
