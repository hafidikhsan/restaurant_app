import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/providers/result_state.dart';
import 'package:restaurant_app/screens/error_page.dart';
import 'package:restaurant_app/widgets/app_bar.dart';
import 'package:restaurant_app/widgets/custom_card_home.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return CustomScrollView(slivers: <Widget>[
            const CustomAppBar(
              titlePage: 'Favorite',
              floatingValue: true,
              centerTitleValue: false,
              pinnedValue: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var restaurantsData = provider.favorite[index];
                  return CustomCardHome(
                    restaurants: restaurantsData,
                  );
                },
                childCount: provider.favorite.length,
              ),
            ),
          ]);
        } else {
          return const ErrorPage(
            image: Icons.sentiment_dissatisfied,
            massage: "Belum ada Restaurant Favorite",
            title: "Favorite",
          );
        }
      },
    );
  }
}
