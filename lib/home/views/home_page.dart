import 'package:flutter/material.dart';
import 'package:parity_cube_assessment/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: HomeView());
  }
}
