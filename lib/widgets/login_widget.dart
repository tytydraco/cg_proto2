import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/auth/demo_remote_auth.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:cg_proto2/widgets/login_save_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A dialog that handles user authentication with the remote server.
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
  final formKey = GlobalKey<FormState>();
  bool tryingAuthentication = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> shouldSaveCredentials() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('save_credentials') ?? false;
  }

  Future<CredentialModel> getSavedCredentials() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final savedUsername = sharedPrefs.getString('saved_username') ?? '';
    final savedPassword = sharedPrefs.getString('saved_password') ?? '';
    return CredentialModel(savedUsername, savedPassword);
  }

  Future setSavedCredentials(CredentialModel credentials) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('saved_username', credentials.username);
    sharedPrefs.setString('saved_password', credentials.password);
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
    if (formKey.currentState!.validate()) {
      setState(() => tryingAuthentication = true);

      final remoteAuth = DemoRemoteAuth();
      final credential = CredentialModel(
          usernameController.text, passwordController.text);
      final success = await remoteAuth.checkCredentials(credential);

      setState(() => tryingAuthentication = false);
      if (success) {
        final saveCredentials = await shouldSaveCredentials();
        if (saveCredentials) {
          setSavedCredentials(credential);
        }

        widget.onSuccess();
      } else {
        usernameController.text = '';
        passwordController.text = '';
        setSavedCredentials(CredentialModel('', ''));
        widget.onFailed();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    importSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    if (!tryingAuthentication) {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
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
        ),
      );
    } else {
      return const LoadingSpinner();
    }
  }
}
