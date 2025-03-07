import 'package:app_datasource/app_datasource.dart';
import 'package:flutter/material.dart';
import 'package:parity_cube_assessment/deals/deals.dart';
import 'package:parity_cube_assessment/deals/listings/views/deals_listing_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              tabs: [
                Tab(text: 'Top'),
                Tab(text: 'Popular'),
                Tab(text: 'Featured'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                DealsListingPage(),
                DealsListingPage(dealListingType: DealListingType.popular),
                DealsListingPage(dealListingType: DealListingType.featured),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
