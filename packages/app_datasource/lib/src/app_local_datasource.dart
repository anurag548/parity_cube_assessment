part of 'app_data_source.dart';

/// {@template app_local_datasource}
/// Class for storing the deals model to the local storage.
/// {@endtemplate}
abstract interface class AppLocalDataSource extends AppDataSource {
  @override
  Future<DealModelList> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  });

  /// Writes the deals model to the local storage.
  Future<bool> writeDeals({
    required DealListingType dealCategory,
    required DealModel dealModel,
  });
}

/// {@template app_local_datasource_impl}
/// Implementation class of the local data source.
/// {@endtemplate}
class AppLocalDatasourceImpl implements AppLocalDataSource {
  /// {@macro app_local_datasource_impl}
  const AppLocalDatasourceImpl({
    required Database database,
  }) : _database = database;

  final Database _database;

  static final Map<DealListingType, DealModelList> _dealsListCache = {
    DealListingType.top: [],
    DealListingType.featured: [],
    DealListingType.popular: [],
  };

  @override
  Future<DealModelList> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  }) async {
    final data = await _database.query(
      'deals_tbl',
      where: 'deal_category = ?',
      whereArgs: [dealCategory.name],
      limit: 12,
      offset: _dealsListCache[dealCategory]?.length,
    );

    final dealsModelList = data.map(DealModel.fromJson).toList();

    _dealsListCache.update(
      dealCategory,
      (dealsList) => List.from(dealsList)..addAll(dealsModelList),
    );

    return dealsModelList;
  }

  @override
  Future<bool> writeDeals({
    required DealListingType dealCategory,
    required DealModel dealModel,
  }) async {
    try {
      final insertOp = await _database.insert(
        'deals_tbl',
        dealModel.toJson()
          ..addAll({
            'deal_category': dealCategory.name,
          }),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return insertOp != 0;
    } catch (error) {
      rethrow;
    }
  }
}
