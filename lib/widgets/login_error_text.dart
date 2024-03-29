import 'package:flutter/material.dart';

/// A text box that displays an error message caused by a failed login attempt.
class LoginErrorText extends StatelessWidget {
  final bool show;

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
