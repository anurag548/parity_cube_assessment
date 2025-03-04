import 'dart:convert';
import 'dart:io';

import 'package:app_datasource/src/models/models.dart';
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

  /// Fetches the data which is to be displayed on the home screen.
  Future<DealModelList> getHomeDeals({
    HomePageDealType dealCategory = HomePageDealType.top,
    int pageNumber = 1,
  }) async {
    final url = Uri.http(
      'stagingauth.desidime.com',
      // ignore: prefer_interpolation_to_compose_strings
      '/v4/home' + dealCategory.endpoint,
      {
        'per_page': '12',
        'page': pageNumber.toString(),
        // 'fields':
        //     'id,created_at,created_at_in_millis,image_medium,comments_count,title,permalink',
      },
    );

    final response = await _httpClient.get(
      url,
      headers: _getHeaders(),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw AppApiRequestFailure(response.body);
    }

    final json = response.json;

    return (json['deals'] as List)
        .map((deal) => DealModel.fromJson(deal as Map<String, dynamic>))
        .toList();
  }

  Map<String, String> _getHeaders() {
    return {
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9',
    };
  }
}

extension on Response {
  Map<String, dynamic> get json => jsonDecode(body) as Map<String, dynamic>;
}
