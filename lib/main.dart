import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';
import 'package:http/http.dart' as http;
import 'package:parity_cube_assessment/app/app.dart';
import 'package:parity_cube_assessment/bootstrap.dart';

void main() {
  bootstrap(() {
    final appRepository = AppRepository(
      appDataSource: AppDatasource(httpClient: http.Client()),
    );

    return App(appRepository: appRepository);
  });
}
