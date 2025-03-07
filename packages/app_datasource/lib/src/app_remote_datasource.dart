part of 'app_data_source.dart';

abstract interface class AppRemoteDatasource extends AppDataSource {
  @override
  Future<DealModelList> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  });
}

/// {@template app_datasource}
/// data source package for the app
/// {@endtemplate}
class AppRemoteDatasourceImpl implements AppRemoteDatasource {
  /// {@macro app_datasource}
  const AppRemoteDatasourceImpl({
    required Client httpClient,
  }) : _httpClient = httpClient;

  final Client _httpClient;

  /// Fetches the data which is to be displayed on the home screen.
  @override
  Future<DealModelList> getDeals({
    DealListingType dealCategory = DealListingType.top,
    int pageNumber = 1,
    int perPage = 12,
  }) async {
    final url = Uri.http(
      'stagingauth.desidime.com',
      // ignore: prefer_interpolation_to_compose_strings
      '/v4/home' + dealCategory.endpoint,
      {
        'per_page': perPage.toString(),
        'page': pageNumber.toString(),
        'fields':
            'id,created_at,created_at_in_millis,image_medium,comments_count,title,permalink',
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
