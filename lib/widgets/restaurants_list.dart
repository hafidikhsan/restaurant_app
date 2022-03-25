import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/resutl_state.dart';
import 'package:restaurant_app/screens/error_page.dart';
import 'package:restaurant_app/widgets/app_bar.dart';
import 'package:restaurant_app/widgets/custom_card_home.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/widgets/internet_widget.dart';
import 'package:restaurant_app/services/background_service.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
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
          return const CustomScrollView(
            slivers: <Widget>[
              CustomAppBar(
                titlePage: 'Restaurant App',
                floatingValue: true,
                centerTitleValue: false,
                pinnedValue: false,
              ),
              SliverToBoxAdapter(
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
              const CustomAppBar(
                titlePage: 'Restaurant App',
                floatingValue: true,
                centerTitleValue: false,
                pinnedValue: false,
              ),
              SliverToBoxAdapter(
                child: _title(context),
              ),
              SliverToBoxAdapter(
                child: _shortButton(context),
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

  Widget _shortButton(BuildContext context) {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200.0,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: (state.short)
                      ? MaterialStateProperty.all(
                          const Color.fromARGB(255, 42, 66, 131),
                        )
                      : null,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                onPressed: () {
                  state.short = !state.short;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.filter_list,
                      color: state.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text(
                        'Urutkan Rating',
                        style: TextStyle(
                          color: state.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _backgroundButton(BuildContext context) {
    return Consumer<RestaurantsProvider>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200.0,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: (state.short)
                      ? MaterialStateProperty.all(
                          const Color.fromARGB(255, 42, 66, 131),
                        )
                      : null,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  await AndroidAlarmManager.oneShot(
                    Duration(seconds: 5),
                    1,
                    BackgroundService.callback,
                    exact: true,
                    wakeup: true,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.filter_list,
                      color: state.color,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text(
                        'Background',
                        style: TextStyle(
                          color: state.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _titleText(BuildContext context, String title, String type) {
    return Text(
      title,
      style: (type == "headline5")
          ? Theme.of(context).textTheme.headline5
          : (type == "headline4")
              ? Theme.of(context).textTheme.headline4
              : Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _titleText(
            context,
            "Selamat Datang",
            "headline5",
          ),
          _titleText(
            context,
            "Hafid Ikhsan Arifin",
            "headline4",
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: _titleText(
              context,
              "Makan apa hari ini?",
              "subtitle1",
            ),
          ),
        ],
      ),
    );
  }
}
