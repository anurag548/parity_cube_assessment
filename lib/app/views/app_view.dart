import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parity_cube_assessment/home/home.dart';

class App extends StatelessWidget {
  const App({required appRepository, super.key})
    : _appRepository = appRepository;

  final AppRepository _appRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _appRepository,
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: HomePage(),
      ),
    );
  }
}
