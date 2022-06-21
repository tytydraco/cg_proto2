/// Abstract class to handle remote database interactions.
abstract class RemoteDatabaseImplementation {
  /// Returns a list of maps from the live database.
  Future<List<Map<String, dynamic>>> getEntries();

  /// Returns the most recent weather map given a SiteModel.
  Future<Map<String, dynamic>> getCurrentWeather(String siteName);

  /// Returns all prior weather maps given a SiteModel.
  Future<List<Map<String, dynamic>>> getHistoricalWeather(String siteName);
}