import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';

/// {@template app_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AppRepository {
  /// {@macro app_repository}
  const AppRepository({
    required AppRemoteDatasource appRemoteDataSource,
    required AppLocalDataSource appLocalDataSource,
  })  : _appRemoteDatasource = appRemoteDataSource,
        _appLocalDataSource = appLocalDataSource;

  /// The Datasource to fetch the data from the server.
  final AppRemoteDatasource _appRemoteDatasource;

  final AppLocalDataSource _appLocalDataSource;

  ///
  Future<List<DealEntity>> getHomeDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  }) async {
    try {
      final List<DealEntity> dealsList;

      final localDealsList = await _appLocalDataSource.getDeals(
        dealCategory: dealCategory,
        pageNumber: pageNumber,
        perPage: perPage,
      );
      if (localDealsList.isNotEmpty) {
        dealsList =
            localDealsList.map<DealEntity>(DealEntity.fromDealModel).toList();
      } else {
        final remoteDealList = await _appRemoteDatasource.getDeals(
          dealCategory: dealCategory,
          pageNumber: pageNumber,
        );
        dealsList = remoteDealList.map<DealEntity>((dealModel) {
          _appLocalDataSource.writeDeals(
            dealCategory: dealCategory,
            dealModel: dealModel,
          );
          return DealEntity.fromDealModel(dealModel);
        }).toList();
      }

      return dealsList;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        error,
        stackTrace,
      );
    }
  }
}
