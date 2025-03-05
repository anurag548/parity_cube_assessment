part of 'deals_listing_bloc.dart';

@immutable
sealed class DealsListingEvent {
  const DealsListingEvent();
}

final class FetchDealsListing extends DealsListingEvent {
  const FetchDealsListing({required this.dealListingType});

  final DealListingType dealListingType;
}

final class FetchMoreDeals extends DealsListingEvent {
  const FetchMoreDeals(this.pageNumber);

  final int pageNumber;
}
