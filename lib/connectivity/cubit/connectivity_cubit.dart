import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityCubit extends Cubit<bool> {
  ConnectivityCubit({
    required InternetConnectionChecker internetConnectionChecker,
  }) : super(true) {
    _streamSubscription = internetConnectionChecker.onStatusChange.listen((
      internetConnectionStatus,
    ) {
      if (internetConnectionStatus != InternetConnectionStatus.connected) {
        emit(false);
      }
      if (internetConnectionStatus == InternetConnectionStatus.connected) {
        emit(true);
      }
    });
  }

  late final StreamSubscription _streamSubscription;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
