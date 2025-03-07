import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_datasource/app_datasource.dart';
import 'package:app_datasource/src/models/models.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

part 'app_local_datasource.dart';
part 'app_remote_datasource.dart';

/// {@template app_datasource}
///
/// {@endtemplate}
abstract interface class AppDataSource {
  /// Interface method for storing the deals.
  Future<DealModelList> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  });
}
