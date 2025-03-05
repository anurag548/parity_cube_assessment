part of 'deals_listing_bloc.dart';

enum DealsListingStatus { initial, loading, fetched, failure }

extension DealsListingStatusX on DealsListingStatus {
  bool get isSuccess => this == DealsListingStatus.fetched;
}

final class DealsListingState extends Equatable {
  const DealsListingState({
    this.dealsListingType = DealListingType.top,
    this.status = DealsListingStatus.initial,
    this.dealsEntityList = const <DealEntity>[],
    this.pageNumber = 1,
    this.hasReachedMax = false,
  });

  DealsListingState copyWith({
    DealsListingStatus? status,
    List<DealEntity>? dealsEntityList,
    int? pageNumber,
    bool? hasReachedMax,
  }) {
    return DealsListingState(
      status: status ?? this.status,
      pageNumber: pageNumber ?? this.pageNumber,
      dealsEntityList: dealsEntityList ?? this.dealsEntityList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  final DealListingType dealsListingType;

  final DealsListingStatus status;

  final List<DealEntity> dealsEntityList;

  final int pageNumber;

  final bool hasReachedMax;

  @override
  List<Object> get props => [
    status,
    dealsEntityList,
    pageNumber,
    hasReachedMax,
  ];
}
