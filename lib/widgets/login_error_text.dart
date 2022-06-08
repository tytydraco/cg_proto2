import 'package:flutter/material.dart';

class LoginErrorText extends StatelessWidget {
  final show;

  const LoginErrorText({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: const Text(
        'Authentication failed; please try again',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
