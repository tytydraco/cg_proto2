import 'package:cg_proto2/screens/home_page.dart';
import 'package:cg_proto2/widgets/login_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void goHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    ).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: LoginWidget(
          onSuccess: () => goHome(),
          onFailed: () {
            // TODO: handle error message
          },
        )
      ),
    );
  }
}
