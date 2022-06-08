import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/remote_auth.dart';
import 'package:cg_proto2/widgets/login_save_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> shouldSaveCredentials() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('save_credentials') ?? false;
  }

  Future putSavedCredentials(CredentialModel credentials) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('saved_username', credentials.username);
    sharedPrefs.setString('saved_password', credentials.password);
  }

  Future<CredentialModel> getSavedCredentials() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final savedUsername = sharedPrefs.getString('saved_username') ?? '';
    final savedPassword = sharedPrefs.getString('saved_password') ?? '';
    return CredentialModel(savedUsername, savedPassword);
  }

  Future importSavedCredentials() async {
    final saveCredentials = await shouldSaveCredentials();
    if (saveCredentials) {
      final savedCredentials = await getSavedCredentials();
      usernameController.text = savedCredentials.username;
      passwordController.text = savedCredentials.password;
    }
  }

  Future attemptLogin() async {
    final remoteAuth = RemoteAuth();
    final credential = CredentialModel(usernameController.text, passwordController.text);
    final success = await remoteAuth.checkCredentials(credential);

    if (success) {
      final saveCredentials = await shouldSaveCredentials();
      if (saveCredentials) {
        await putSavedCredentials(credential);
      }
      widget.onSuccess();
    } else {
      passwordController.clear();
      putSavedCredentials(CredentialModel('', ''));
      widget.onFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    importSavedCredentials();

    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(hintText: 'Username'),
        ),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(hintText: 'Password'),
          obscureText: true,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton(
            onPressed: () => attemptLogin(),
            child: const Text('Login'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: LoginSaveCheckbox(),
        ),
      ],
    );
  }
}
