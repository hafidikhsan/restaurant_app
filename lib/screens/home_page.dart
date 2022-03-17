import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/widgets/custom_card_home.dart';

class HomePage extends StatefulWidget {
  static var routeName = '/restaurant_list';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Restaurant>>(
      future: loadProduct(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        Widget newsListSliver;
        if (snapshot.hasData) {
          newsListSliver = SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final restaurantsData = data![index];
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
            SliverAppBar(
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
            ),
            SliverToBoxAdapter(child: _title(context)),
            newsListSliver,
          ],
        );
      },
    ));
  }

  Widget _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Selamat Datang",
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            "Hafid Ikhsan Arifin",
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Makan apa hari ini?",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
