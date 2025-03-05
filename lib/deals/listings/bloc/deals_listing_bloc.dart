import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'deals_listing_event.dart';
part 'deals_listing_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class DealsListingBloc extends Bloc<DealsListingEvent, DealsListingState> {
  DealsListingBloc({required AppRepository appRepository})
    : _appRepository = appRepository,
      super(DealsListingState()) {
    on<FetchDealsListing>(_onFetchDealsListing);
    on<FetchMoreDeals>(
      _onFetchMoreDeals,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final AppRepository _appRepository;

  Future<void> _onFetchDealsListing(
    FetchDealsListing event,
    Emitter<DealsListingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DealsListingStatus.loading));
      final dealsList = await _appRepository.getHomeDeals(
        dealCategory: event.dealListingType,
      );

      emit(
        state.copyWith(
          status: DealsListingStatus.fetched,
          dealsEntityList: dealsList,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  Future<void> _onFetchMoreDeals(
    FetchMoreDeals event,
    Emitter<DealsListingState> emit,
  ) async {
    try {
      final dealsList = await _appRepository.getHomeDeals(
        dealCategory: DealListingType.top,
        pageNumber: event.pageNumber,
      );

      emit(
        state.copyWith(
          dealsEntityList: List.from(state.dealsEntityList)..addAll(dealsList),
          pageNumber: event.pageNumber,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }
}
