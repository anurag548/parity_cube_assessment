import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:parity_cube_assessment/connectivity/connectivity.dart';
import 'package:parity_cube_assessment/home/home.dart';

class AppControls {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerStateKey =
      GlobalKey<ScaffoldMessengerState>();
}

class App extends StatelessWidget {
  const App({required appRepository, super.key})
    : _appRepository = appRepository;

  final AppRepository _appRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _appRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ConnectivityCubit(
                internetConnectionChecker: InternetConnectionChecker.instance,
              );
            },
          ),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: AppControls.scaffoldMessengerStateKey,
          theme: ThemeData(useMaterial3: true),
          home: HomePage(),
        ),
      ),
    );
  }
}
