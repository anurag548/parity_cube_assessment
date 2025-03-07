import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';

/// {@template app_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AppRepository {
  /// {@macro app_repository}
  const AppRepository({
    required AppDatasource appDataSource,
    required AppLocalDataSource appLocalDataSource,
  })  : _appDatasource = appDataSource,
        _appLocalDataSource = appLocalDataSource;

  /// The Datasource to fetch the data from the server.
  final AppDatasource _appDatasource;

  final AppLocalDataSource _appLocalDataSource;

  static const Map<DealListingType, DealModelList> dealsMap = {
    DealListingType.top: [],
    DealListingType.featured: [],
    DealListingType.popular: [],
  };

  List<DealEntity> get _getDealsList = 

  ///
  Future<List<DealEntity>> getHomeDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  }) async {
    try {



      final dealsList = await _appDatasource.getHomeDeals(
        dealCategory: dealCategory,
        pageNumber: pageNumber,
      );

      return dealsList.map<DealEntity>((dealModel) {
        _appLocalDataSource.writeDeals(
          dealCategory: dealCategory,
          dealModel: dealModel,
        );
        return DealEntity.fromDealModel(dealModel);
      }).toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        error,
        stackTrace,
      );
    }
  }
}
