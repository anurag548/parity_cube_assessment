import 'package:equatable/equatable.dart';

/// List of DealModel
typedef DealModelList = List<DealModel>;

/// {@template home_page_deals}
/// Enum specifying the home page deal category.
///{@endtemplate}
enum HomePageDealType {
  /// Top deals.
  top('/new'),

  /// Popular deals.
  popular('/discussed'),

  /// Featured Deals.
  featured('/discussed');

  const HomePageDealType(this.endpoint);

  /// Specifies which endpoint to contact for specific url.
  final String endpoint;
}

/// {@template deals_model}
/// Parses and stores the response of the deal model.
/// {@endtemplate}
class DealModel extends Equatable {
  /// {@macro deals_model}
  const DealModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.commentCount,
    required this.imageUrl,
  });

  /// Converts to an instance [DealModel] from response json map.
  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'] as int,
      commentCount: json['comments_count'] as int,
      createdAt: json['created_at_in_millis'] as int,
      imageUrl: json['image_medium'] as String,
      title: json['title'] as String,
    );
  }

  /// Converts the instance of this class to Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comments_count': commentCount,
      'created_at_in_millis': createdAt,
      'imageUrl': imageUrl,
      'title': title,
    };
  }

  /// Stores the id of the deal.
  final int id;

  /// title of the deal.
  final String title;

  /// When the deal was created in timeStamp
  final int createdAt;

  /// Number of comments made on the deal.
  final int commentCount;

  /// Thumbnail image of the deal.
  final String imageUrl;

  @override
  List<Object> get props => [
        id,
        title,
        createdAt,
        commentCount,
        imageUrl,
      ];
}
