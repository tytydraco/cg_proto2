import 'package:cg_proto2/models/credential_model.dart';

class RemoteAuth {
  Future<bool> checkCredentials(CredentialModel credentials) async {
    if (credentials.username == 'test' && credentials.password == 'test') {
      return true;
    } else {
      return false;
    }
  }
}