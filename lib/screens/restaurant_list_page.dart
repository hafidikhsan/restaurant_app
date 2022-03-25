import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/result_state.dart';
import 'package:restaurant_app/screens/error_page.dart';
import 'package:restaurant_app/widgets/app_bar.dart';
import 'package:restaurant_app/widgets/custom_card_home.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/widgets/home_title.dart';
import 'package:restaurant_app/widgets/internet_widget.dart';
import 'package:restaurant_app/widgets/short_button.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return InternetCheck(
      onlineBuilder: _internetConnected,
      offlineBuilder: _internetDisconnected,
    );
  }

  Widget _internetConnected(BuildContext context) {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return CustomScrollView(
            slivers: <Widget>[
              _appbar(context),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          );
        } else if (state.state == ResultState.hasData) {
          return CustomScrollView(
            slivers: <Widget>[
              _appbar(context),
              const SliverToBoxAdapter(
                child: HomeTitle(),
              ),
              const SliverToBoxAdapter(
                child: ShortButton(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    (state.short)
                        ? state.result.restaurants.sort(
                            ((a, b) => b.rating.compareTo(a.rating)),
                          )
                        : state.result.restaurants[index];
                    var restaurantsData = state.result.restaurants[index];
                    return CustomCardHome(
                      restaurants: restaurantsData,
                    );
                  },
                  childCount: state.result.restaurants.length,
                ),
              ),
            ],
          );
        } else if (state.state == ResultState.noData) {
          return const ErrorPage(
            image: Icons.sentiment_very_dissatisfied,
            massage: "Maaf Data tidak ditemukan",
            title: "Restaurant App",
          );
        } else if (state.state == ResultState.error) {
          return const ErrorPage(
            image: Icons.sentiment_dissatisfied,
            massage: "Maaf terjadi error dengan server",
            title: "Restaurant App",
          );
        } else {
          return const ErrorPage(
            image: Icons.refresh,
            massage: "Maaf terjadi error, refresh kembali halaman",
            title: "Restaurant App",
          );
        }
      },
    );
  }

  Widget _internetDisconnected(BuildContext context) {
    return const ErrorPage(
      image: Icons.wifi_off,
      massage: "Aduh, Koneksi internet mati!",
      title: "Restaurant App",
    );
  }

  Widget _appbar(BuildContext context) {
    return const CustomAppBar(
      titlePage: 'Restaurant App',
      floatingValue: true,
      centerTitleValue: false,
      pinnedValue: false,
    );
  }
}
