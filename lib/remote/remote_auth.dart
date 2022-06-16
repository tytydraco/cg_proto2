import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/remote_auth_implementation.dart';

/// Offline demo implementation of the remote authentication using sample login info.
class DemoRemoteAuth implements RemoteAuthImplementation {
  @override
  Future<bool> checkCredentials(CredentialModel credentials) async {
    await Future.delayed(const Duration(seconds: 1));
    if (credentials.username == 'test' && credentials.password == 'test') {
      return true;
    } else {
      return false;
    }
  }
}