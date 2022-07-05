import 'package:artificial_delay/artificial_delay.dart';
import 'package:cg_proto2/models/credential_model.dart';
import 'package:cg_proto2/remote/auth/remote_auth_implementation.dart';

/// Offline demo implementation of the remote authentication using sample login info.
class DemoRemoteAuth implements RemoteAuthImplementation {
  final _artificialDelay = ArtificialDelay(
    minDelay: const Duration(milliseconds: 70),
    maxDelay: const Duration(milliseconds: 200),
  );

  @override
  Future<bool> checkCredentials(CredentialModel credentials) async {
    await _artificialDelay.trigger();
    return credentials.username == 'test' && credentials.password == 'test';
  }
}