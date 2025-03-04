import 'package:http/http.dart';

/// {@template app_datasource}
/// data source package for the app
/// {@endtemplate}
class AppDatasource {
  /// {@macro app_datasource}
  const AppDatasource({
    required Client httpClient,
  }) : _httpClient = httpClient;

  final Client _httpClient;
}
