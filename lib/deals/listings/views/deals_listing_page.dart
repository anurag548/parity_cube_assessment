import 'package:app_datasource/app_datasource.dart';
import 'package:app_repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parity_cube_assessment/deals/deals.dart';

class DealsListingPage extends StatelessWidget {
  const DealsListingPage({
    this.dealListingType = DealListingType.top,
    super.key,
  });

  final DealListingType dealListingType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DealsListingBloc(appRepository: context.read<AppRepository>())
                ..add(FetchDealsListing(dealListingType: dealListingType)),
      child: DealsListingView(),
    );
  }
}
