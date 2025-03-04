import 'dart:convert';

import 'package:app_datasource/app_datasource.dart';
import 'package:test/test.dart';

import '../fixture/fixture.dart';

void main() {
  late final Map<String, dynamic> json;

  late final DealModel dealModel;
  setUpAll(() {
    json = jsonDecode(fixture('deal_model.json')) as Map<String, dynamic>;

    dealModel = DealModel.fromJson(json);
  });

  group(
    'DealModel',
    () {
      test('fromJson', () {
        expect(
          dealModel,
          isA<DealModel>()
              .having(
                (dealModel) => dealModel.id,
                'ID matches the json value',
                json['id'] as int,
              )
              .having(
                (dealModel) => dealModel.title,
                'title matches the json value',
                json['title'] as String,
              )
              .having(
                (dealModel) => dealModel.createdAt,
                'title matches the json value',
                json['created_at_in_millis'] as int,
              )
              .having(
                (dealModel) => dealModel.commentCount,
                'comment count matches the json value',
                json['comments_count'] as int,
              ),
        );
      });

      test('toJson', () {
        expect(dealModel.toJson(), isA<Map<String, dynamic>>());
      });
    },
  );
}
