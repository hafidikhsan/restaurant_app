import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/detail_provider.dart';

class DetailList extends StatefulWidget {
  const DetailList({Key? key}) : super(key: key);

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  bool _desc = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantsDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          final drinkList = state.result.restaurant.menus.drinks.length;
          final foodList = state.result.restaurant.menus.foods.length;

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
                                    context, state.result.restaurant.pictureId),
                              )
                            : _detailHero(
                                context, state.result.restaurant.pictureId),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _detailDescription(
                    context,
                    state.result.restaurant.description,
                    state.result.restaurant.name,
                    state.result.restaurant.rating,
                    state.result.restaurant.city),
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
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _detailHero(BuildContext context, String pictId) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://restaurant-api.dicoding.dev/images/small/${pictId}"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _detailDescription(BuildContext context, String description,
      String name, double rating, String city) {
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
                          style: Theme.of(context).textTheme.caption!.merge(
                                const TextStyle(color: Colors.blue),
                              ),
                        )
                      : Text(
                          "Selengkapnya",
                          style: Theme.of(context).textTheme.caption!.merge(
                                const TextStyle(color: Colors.blue),
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
              children: <Widget>[
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
}
