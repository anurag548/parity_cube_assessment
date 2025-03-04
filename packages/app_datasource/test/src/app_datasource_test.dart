import 'dart:convert';
import 'dart:io';

import 'package:app_datasource/app_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'fixture/fixture.dart';

class MockHttpClient extends Mock implements http.Client {}

Matcher isAUriHaving({String? authority, String? path, String? query}) {
  return predicate<Uri>((uri) {
    authority ??= uri.authority;
    path ??= uri.path;
    query ??= uri.query;

    return uri.authority == authority && uri.path == path && uri.query == query;
  });
}

Matcher areJsonHeaders({String? authorizationToken}) {
  return predicate<Map<String, String>?>((headers) {
    if (headers?[HttpHeaders.contentTypeHeader] != ContentType.json.value ||
        headers?[HttpHeaders.acceptHeader] != ContentType.json.value) {
      return false;
    }
    if (authorizationToken != null &&
        headers?['X-Desidime-Client'] != authorizationToken) {
      return false;
    }
    return true;
  });
}

void main() {
  late final http.Client httpClient;

  late final AppDatasource appDataSource;

  setUpAll(() {
    registerFallbackValue(Uri());
    httpClient = MockHttpClient();
    appDataSource = AppDatasource(httpClient: httpClient);
  });

  setUp(() {
    when(
      () => httpClient.get(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        fixture('deal_model_list.json'),
        HttpStatus.ok,
      ),
    );
  });

  group('AppDatasource', () {
    test('can be instantiated', () {
      expect(
        AppDatasource(httpClient: httpClient),
        isNotNull,
      );
    });

    group(
      'getHomeData',
      () {
        test(
          'has proper base url',
          () async {
            await appDataSource.getHomeDeals();

            verify(
              () => httpClient.get(
                any(
                  that: isAUriHaving(
                    authority: 'stagingauth.desidime.com',
                  ),
                ),
              ),
            );
          },
        );

        group(
          'forms proper url based on the passed parameter',
          () {
            test(
              'for HomePageDealType.top',
              () async {
                await appDataSource.getHomeDeals(
                  dealCategory: HomePageDealType.top,
                );

                verify(
                  () => httpClient.get(
                    any(
                      that: isAUriHaving(path: '/v4/home/new'),
                    ),
                  ),
                );
              },
            );

            test(
              'for HomePageDealType.popular',
              () async {
                await appDataSource.getHomeDeals(
                  dealCategory: HomePageDealType.popular,
                );

                verify(
                  () => httpClient.get(
                    any(
                      that: isAUriHaving(path: '/v4/home/discussed'),
                    ),
                  ),
                );
              },
            );

            test(
              'for HomePageDealType.featured',
              () async {
                await appDataSource.getHomeDeals(
                  dealCategory: HomePageDealType.featured,
                );

                verify(
                  () => httpClient.get(
                    any(
                      that: isAUriHaving(path: '/v4/home/discussed'),
                    ),
                  ),
                );
              },
            );
          },
        );

        test('makes corrects request without query param', () async {
          await appDataSource.getHomeDeals();

          const query = 'per_page=12&page=1';

          verify(
            () => httpClient.get(
              any(
                that: isAUriHaving(query: query),
              ),
            ),
          );
        });

        test('makes corrects request without query param', () async {
          await appDataSource.getHomeDeals();

          const query = 'per_page=12&page=1';

          verify(
            () => httpClient.get(
              any(
                that: isAUriHaving(query: query),
              ),
            ),
          );
        });

        test('returns DealModelList properly', () async {
          final dealModelList = await appDataSource.getHomeDeals();

          expect(dealModelList, isA<DealModelList>());
        });

        test('throw AppApiRequestFailure properly', () async {
          when(
            () => httpClient.get(any(), headers: any(named: 'headers')),
          ).thenAnswer(
            (_) async => http.Response(
              '{}',
              HttpStatus.forbidden,
            ),
          );

          expect(
            () => appDataSource.getHomeDeals(),
            throwsA(isA<AppApiRequestFailure>()),
          );
        });

        test(
          'makes correct request with proper authorisation token',
          () async {
            await appDataSource.getHomeDeals();

            verify(
              () => httpClient.get(
                any(),
                headers: any(
                  named: 'headers',
                  that: areJsonHeaders(
                    authorizationToken: '08b4260e5585f282d1bd9d085e743fd9',
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  });
}
