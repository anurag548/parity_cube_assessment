import 'package:app_datasource/app_datasource.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class AppDataSource {
  Future<void> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
  });
}

abstract interface class AppLocalDataSource extends AppDataSource {
  // Future<void> getLocal

  @override
  Future<DealModel> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
  });

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

  @override
  Future<DealModel> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
  }) async {
    await _database.query(
      'deals_tbl',
      where: dealCategory.name,
    );

    final data = <String, dynamic>{};

    return DealModel.fromJson(data);
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
