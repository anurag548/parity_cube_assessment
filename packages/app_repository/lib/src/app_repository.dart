import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';

/// {@template app_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AppRepository {
  /// {@macro app_repository}
  const AppRepository({
    required AppDatasource appDataSource,
  }) : _appDatasource = appDataSource;

  /// The Datasource to fetch the data from the server.
  final AppDatasource _appDatasource;

  ///
  Future<List<DealEntity>> getHomeDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
  }) async {
    try {
      final dealsList = await _appDatasource.getHomeDeals(
        dealCategory: dealCategory,
        pageNumber: pageNumber,
      );

      return dealsList.map<DealEntity>(DealEntity.fromDealModel).toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        error,
        stackTrace,
      );
    }
  }
}
