import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parity_cube_assessment/app/app.dart';
import 'package:parity_cube_assessment/connectivity/cubit/connectivity_cubit.dart';
import 'package:parity_cube_assessment/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, bool>(
      listener: (context, state) {
        if (!state) {
          AppControls.scaffoldMessengerStateKey.currentState?.showSnackBar(
            SnackBar(
              content: Text("No Internet connection showing data from cache"),
              duration: Duration(days: 365),
            ),
          );
          return;
        }
        if (state) {
          AppControls.scaffoldMessengerStateKey.currentState
              ?.hideCurrentSnackBar();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Deals'),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                log('Search Pressed');
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        drawer: Drawer(),
        body: HomeView(),
      ),
    );
  }
}
