import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/widgets/custom_card_home.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  bool _short = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: loadProduct(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        Widget newsListSliver;
        if (snapshot.hasData) {
          newsListSliver = SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              (_short)
                  ? data!.sort(((a, b) => b.rating.compareTo(a.rating)))
                  : data![index];
              final restaurantsData = data[index];
              return CustomCardHome(
                restaurants: restaurantsData,
              );
            },
            childCount: data!.length,
          ));
        } else {
          newsListSliver = const SliverToBoxAdapter(
            child: CircularProgressIndicator(),
          );
        }
        return CustomScrollView(
          slivers: <Widget>[
            _appBar(context),
            SliverToBoxAdapter(child: _title(context)),
            SliverToBoxAdapter(child: _shortButton(context)),
            newsListSliver,
          ],
        );
      },
    );
  }

  Widget _shortButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 40.0,
          child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
            ),
            onPressed: () {
              setState(() {
                _short = !_short;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.filter_list,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('Urutkan Rating'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      floating: true,
      title: const Text("Restaurant App"),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
              Color.fromARGB(255, 42, 66, 131),
              Color.fromARGB(255, 30, 47, 92)
            ]))),
      ),
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
          _titleText(context, "Selamat Datang", "headline5"),
          _titleText(context, "Hafid Ikhsan Arifin", "headline4"),
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: _titleText(context, "Makan apa hari ini?", "subtitle1")),
        ],
      ),
    );
  }
}
