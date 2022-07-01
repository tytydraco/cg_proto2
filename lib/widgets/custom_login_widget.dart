import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/auth/demo_remote_auth.dart';
import 'package:cg_proto2/widgets/loading_spinner.dart';
import 'package:cg_proto2/widgets/login_save_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:login_widget/login_field_widget.dart';
import 'package:login_widget/login_form_widget.dart';
import 'package:login_widget/login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A dialog that handles user authentication with the remote server.
class CustomLoginWidget extends StatefulWidget {
  final Function onSuccess;
  final Function onFailed;

  const CustomLoginWidget({
    Key? key,
    required this.onSuccess,
    required this.onFailed
  }) : super(key: key);

  @override
  State<CustomLoginWidget> createState() => _CustomLoginWidgetState();
}

class _CustomLoginWidgetState extends State<CustomLoginWidget> {
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
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Column(
            children: [
              LoginWidget(
                form: LoginFormWidget(
                  formKey: formKey,
                  loginFields: [
                    LoginFieldWidget(
                      controller: usernameController,
                      hintText: 'Username',
                      autofocus: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                    ),
                    LoginFieldWidget(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                loginButtonText: 'Log in',
                onSubmit: attemptLogin
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: LoginSaveCheckbox(),
              ),
            ]
          ),
        ),
      );
    } else {
      return const LoadingSpinner();
    }
  }
}
