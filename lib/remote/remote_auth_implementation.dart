import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/models/site_weather_model.dart';

/// Abstract class to handle remote authorization.
abstract class RemoteAuthImplementation {
  /// Checks [credentials] against the remote server; return true if authorization succeeds.
  Future<bool> checkCredentials(CredentialModel credentials);
}