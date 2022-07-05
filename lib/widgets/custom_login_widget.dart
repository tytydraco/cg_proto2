import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/auth/demo_remote_auth.dart';
import 'package:cg_proto2/widgets/login_save_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:login_widget/login_field_widget.dart';
import 'package:login_widget/login_form_widget.dart';
import 'package:login_widget/login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A dialog that handles user authentication with the remote server.
class CustomLoginWidget extends StatefulWidget {
  final Function onSuccess;

  const CustomLoginWidget({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<CustomLoginWidget> createState() => _CustomLoginWidgetState();
}

class _CustomLoginWidgetState extends State<CustomLoginWidget> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> _shouldSaveCredentials() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('save_credentials') ?? false;
  }

  Future<CredentialModel> _getSavedCredentials() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final savedUsername = sharedPrefs.getString('saved_username') ?? '';
    final savedPassword = sharedPrefs.getString('saved_password') ?? '';
    return CredentialModel(savedUsername, savedPassword);
  }

  Future<void> _setSavedCredentials(CredentialModel credentials) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('saved_username', credentials.username);
    sharedPrefs.setString('saved_password', credentials.password);
  }

  Future<void> _importSavedCredentials() async {
    final saveCredentials = await _shouldSaveCredentials();
    if (saveCredentials) {
      final savedCredentials = await _getSavedCredentials();
      _usernameController.text = savedCredentials.username;
      _passwordController.text = savedCredentials.password;
    }
  }

  Future<String?> _attemptLogin() async {
    if (_formKey.currentState!.validate()) {
      final remoteAuth = DemoRemoteAuth();
      final credential = CredentialModel(
          _usernameController.text, _passwordController.text);
      final success = await remoteAuth.checkCredentials(credential);

      if (success) {
        final saveCredentials = await _shouldSaveCredentials();
        if (saveCredentials) {
          _setSavedCredentials(credential);
        }

        widget.onSuccess();
      } else {
        _usernameController.text = '';
        _passwordController.text = '';
        _setSavedCredentials(CredentialModel('', ''));

        return 'Authentication failed!';
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _importSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
            children: [
              LoginWidget(
                showLoadingSpinner: true,
                  form: LoginFormWidget(
                    formKey: _formKey,
                    loginFields: [
                      LoginFieldWidget(
                        controller: _usernameController,
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
                        controller: _passwordController,
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
                  onSubmit: _attemptLogin
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: LoginSaveCheckbox(),
              ),
            ]
        ),
      ),
    );
  }
}
