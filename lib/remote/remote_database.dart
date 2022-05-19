import 'package:cg_proto2/models/site_model.dart';
import 'package:cg_proto2/remote/remote_database_implementation.dart';

/// Actual implementation of RemoteDatabase
/// TODO: connect this to live database
class RemoteDatabase implements RemoteDatabaseImplementation {
  @override
  Future<List<SiteModel>> getEntries() async {
    return [
      SiteModel(1, 'Site 1'),
      SiteModel(2, 'Site 2'),
      SiteModel(3, 'Site 3'),
      SiteModel(4, 'Site 4'),
      SiteModel(5, 'Site 5'),
      SiteModel(6, 'Site 6'),
      SiteModel(7, 'Site 7'),
      SiteModel(8, 'Site 8'),
      SiteModel(9, 'Site 9'),
      SiteModel(10, 'Site 10'),
      SiteModel(11, 'Site 11'),
    ];
  }
}