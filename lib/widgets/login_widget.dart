import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/remote_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final Function onSuccess;
  final Function onFailed;

  const LoginWidget({
    Key? key,
    required this.onSuccess,
    required this.onFailed
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var username = '';
  var password = '';

  void attemptLogin() async {
    final remoteAuth = RemoteAuth();
    final credential = CredentialModel(username, password);
    final success = await remoteAuth.checkCredentials(credential);

    if (success) {
      widget.onSuccess();
    } else {
      widget.onFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Username'
          ),
          onChanged: (String value) => username = value,
        ),
        TextFormField(
          decoration: const InputDecoration(
              hintText: 'Password'
          ),
          obscureText: true,
          onChanged: (String value) => password = value,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton(
            onPressed: () => attemptLogin(),
            child: const Text('Login'),
          ),
        ),
      ],
    );
  }
}
