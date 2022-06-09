import 'package:cg_proto2/models/credential_model.dart';

/// Handles user authentication with the backend server.
class RemoteAuth {
  /// Checks [credentials] against the remote server; return true if authorization succeeds.
  Future<bool> checkCredentials(CredentialModel credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    if (credentials.username == 'test' && credentials.password == 'test') {
      return true;
    } else {
      return false;
    }
  }
}