import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';
import 'package:http/http.dart' as http;
import 'package:parity_cube_assessment/app/app.dart';
import 'package:parity_cube_assessment/bootstrap.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  bootstrap(() async {
    final database = await openDatabase(
      '${await getDatabasesPath()}deals.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''CREATE TABLE deals_tbl(
              id INTEGER PRIMARY_KEY, 
              comments_count INTEGER, 
              created_at_in_millis INTEGER,
              title TEXT,
              image_medium TEXT, 
              deal_category TEXT)''');
      },
    );

    final httpClient = http.Client();

    final appRepository = AppRepository(
      appRemoteDataSource: AppRemoteDatasourceImpl(httpClient: httpClient),
      appLocalDataSource: AppLocalDatasourceImpl(database: database),
    );

    return App(appRepository: appRepository);
  });
}
