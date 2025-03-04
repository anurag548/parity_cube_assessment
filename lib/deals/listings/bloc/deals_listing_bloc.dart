import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'deals_listing_event.dart';
part 'deals_listing_state.dart';

class DealsListingBloc extends Bloc<DealsListingEvent, DealsListingState> {
  DealsListingBloc() : super(DealsListingInitial()) {
    on<DealsListingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
