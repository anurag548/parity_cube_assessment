/// {@template app_api_request_failure}
///
/// {@endtemplate}
class AppApiRequestFailure implements Exception {
  /// {@macro app_api_request_failure}
  const AppApiRequestFailure(this.message);

  /// Stores the message for occurrance of the exception
  final String message;
}
