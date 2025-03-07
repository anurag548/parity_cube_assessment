import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parity_cube_assessment/deals/deals.dart';

class DealsListingView extends StatefulWidget {
  const DealsListingView({super.key});

  @override
  State<DealsListingView> createState() => _DealsListingViewState();
}

class _DealsListingViewState extends State<DealsListingView>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<DealsListingBloc, DealsListingState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.dealsEntityList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final deal = state.dealsEntityList[index];
                return Card(
                  // color: Colors.red,
                  // width: double.infinity,
                  // padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () => log('message'),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        spacing: 12,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              CachedNetworkImage(
                                imageUrl: deal.imageUrl,
                                imageBuilder:
                                    (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        image: DecorationImage(
                                          image: imageProvider,
                                        ),
                                      ),
                                    ),
                                width: 150,
                                height: 120,
                              ),

                              Expanded(
                                child: Text(
                                  deal.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Row(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.comment_bank_rounded, size: 18),
                                  Text(
                                    deal.commentCount.toString(),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 4,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.date_range, size: 18),
                                  Text(
                                    DateFormat("dd MMM yyy")
                                        .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            deal.createdAt,
                                          ),
                                        )
                                        .toString(),
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),

                              Spacer(),

                              GestureDetector(
                                child: Text(
                                  'At Other',
                                  style: TextStyle(color: Colors.blue.shade300),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    if (isBottomReached) {
      context.read<DealsListingBloc>().add(
        FetchMoreDeals(context.read<DealsListingBloc>().state.pageNumber + 1),
      );
    }
  }

  bool get isBottomReached {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
