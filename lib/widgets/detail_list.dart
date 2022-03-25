import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/database_helper.dart';
import 'package:restaurant_app/models/api/restaurant_detail.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/providers/detail_provider.dart';
import 'package:restaurant_app/screens/error_page.dart';
import 'package:restaurant_app/widgets/internet_widget.dart';
import 'package:restaurant_app/models/api/restaurant.dart' as restaurants;

class DetailList extends StatefulWidget {
  final restaurants.Restaurant restaurant;
  const DetailList({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  bool _desc = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: InternetCheck(
        onlineBuilder: _internetConnected,
        offlineBuilder: _internetDisconnected,
      ),
    );
  }

  Widget _internetConnected(BuildContext context) {
    return Consumer<RestaurantsDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          final drinkList = state.result.restaurant.menus.drinks.length;
          final foodList = state.result.restaurant.menus.foods.length;
          final reviewList = state.result.restaurant.customerReviews.length;

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                title: Text(
                  state.result.restaurant.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                centerTitle: false,
                expandedHeight: 200.0,
                backgroundColor: const Color.fromARGB(255, 30, 47, 92),
                flexibleSpace: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 42, 66, 131),
                        Color.fromARGB(255, 30, 47, 92),
                      ],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    background:
                        (defaultTargetPlatform == TargetPlatform.android)
                            ? Hero(
                                tag: state.result.restaurant.pictureId,
                                child: _detailHero(
                                  context,
                                  state.result.restaurant.pictureId,
                                ),
                              )
                            : _detailHero(
                                context,
                                state.result.restaurant.pictureId,
                              ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _detailDescription(
                  context,
                  state.result.restaurant.description,
                  state.result.restaurant.name,
                  state.result.restaurant.rating,
                  state.result.restaurant.city,
                  state.result.restaurant.id,
                  state.result.restaurant,
                ),
              ),
              SliverToBoxAdapter(
                child: _menuTitle(context, "Review"),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _detailReview(
                      context,
                      state.result.restaurant.customerReviews[index].name,
                      state.result.restaurant.customerReviews[index].review,
                      state.result.restaurant.customerReviews[index].date,
                    );
                  },
                  childCount: reviewList,
                ),
              ),
              SliverToBoxAdapter(
                child: _menuTitle(context, "Foods"),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _detailMenu(
                      context,
                      state.result.restaurant.menus.foods[index].name,
                      'assets/images/food.jpg',
                    );
                  },
                  childCount: foodList,
                ),
              ),
              SliverToBoxAdapter(
                child: _menuTitle(
                  context,
                  "Drinks",
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return _detailMenu(
                      context,
                      state.result.restaurant.menus.drinks[index].name,
                      'assets/images/drink.jpeg',
                    );
                  },
                  childCount: drinkList,
                ),
              ),
            ],
          );
        } else if (state.state == ResultState.noData) {
          return const ErrorPage(
            image: Icons.sentiment_very_dissatisfied,
            massage: "Maaf Data tidak ditemukan",
            title: "Restaurant Detail",
          );
        } else if (state.state == ResultState.error) {
          return const ErrorPage(
            image: Icons.sentiment_dissatisfied,
            massage: "Maaf terjadi error dengan server",
            title: "Restaurant Detail",
          );
        } else {
          return const ErrorPage(
            image: Icons.refresh,
            massage: "Maaf terjadi error, refresh kembali halaman",
            title: "Restaurant Detail",
          );
        }
      },
    );
  }

  Widget _internetDisconnected(BuildContext context) {
    return const ErrorPage(
      image: Icons.wifi_off,
      massage: "Aduh, Koneksi internet mati!",
      title: "Retaurant Detail",
    );
  }

  Widget _detailHero(BuildContext context, String pictId) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://restaurant-api.dicoding.dev/images/small/$pictId"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _detailDescription(
      BuildContext context,
      String description,
      String name,
      double rating,
      String city,
      String id,
      Restaurant restaurant) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Padding(
              padding: const EdgeInsets.all(
                15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: (_desc)
                            ? Text(
                                description,
                              )
                            : Text(
                                description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                _desc = !_desc;
                              },
                            );
                          },
                          child: (_desc)
                              ? Text(
                                  "Sembunyikan",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .merge(
                                        const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                )
                              : Text(
                                  "Selengkapnya",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .merge(
                                        const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => (isFavorite)
                                    ? provider.removeFavorite(id)
                                    : provider.addFavorite(widget.restaurant),
                                child: (isFavorite)
                                    ? const Icon(
                                        Icons.favorite,
                                        size: 26.0,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                        size: 26.0,
                                      ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Favorite",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _detaiRatingCity(
                            context,
                            rating.toString(),
                            "star",
                          ),
                        ),
                        Expanded(
                          child: _detaiRatingCity(
                            context,
                            city,
                            "city",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _detaiRatingCity(BuildContext context, String description, icons) {
    return Column(
      children: <Widget>[
        Icon(
          (icons == "city") ? Icons.location_city : Icons.star,
          size: 26.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _menuTitle(BuildContext context, String menu) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        menu,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _detailMenu(BuildContext context, menu, String s) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      height: 110,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              child: Image.asset(s, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(menu),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailReview(
    BuildContext context,
    String name,
    String review,
    String date,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
                child: Image.network(
                  "https://i.pinimg.com/474x/65/25/a0/6525a08f1df98a2e3a545fe2ace4be47.jpg",
                  width: 70.0,
                  height: 70.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      review,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
