import 'package:app_datasource/app_datasource.dart';

class DealEntity extends DealModel {
  const DealEntity({
    required super.id,
    required super.commentCount,
    required super.createdAt,
    required super.imageUrl,
    required super.title,
  });

  factory DealEntity.fromDealModel(DealModel dealModel) {
    return DealEntity(
      id: dealModel.id,
      commentCount: dealModel.commentCount,
      createdAt: dealModel.createdAt,
      imageUrl: dealModel.imageUrl,
      title: dealModel.title,
    );
  }

  @override
  List<Object> get props => [
        id,
        commentCount,
        createdAt,
        imageUrl,
        title,
      ];
}
