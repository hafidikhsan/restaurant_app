import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';
import 'package:restaurant_app/widgets/search_card.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  late List<Restaurant> results = [];
  late TextEditingController _controller;
  String queryKey = '';
  List<Restaurant> rows = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
        future: loadProduct(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            rows = data!;
          }
          return CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                title: Text("Pencarian"),
                backgroundColor: Color.fromARGB(255, 30, 47, 92),
                flexibleSpace: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 42, 66, 131),
                        Color.fromARGB(255, 30, 47, 92)
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: 'Restoran favoritmu...'),
                    onSubmitted: (value) {
                      setState(() {
                        queryKey = value;
                        setResults(queryKey);
                      });
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  child: Text("Hasil Pencarian",
                      style: Theme.of(context).textTheme.headline5),
                ),
              ),
              (results.isEmpty)
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final restaurantsData = rows[index];
                        return SearchCard(
                          restaurants: restaurantsData,
                        );
                      },
                      childCount: rows.length,
                    ))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final restaurantsData = results[index];
                        return SearchCard(
                          restaurants: restaurantsData,
                        );
                      },
                      childCount: results.length,
                    ))
            ],
          );
        });
  }

  void setResults(String query) {
    results = rows
        .where((elem) =>
            elem.name.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.isEmpty) {
      (defaultTargetPlatform == TargetPlatform.android)
          ? showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Center(
                      child:
                          Icon(Icons.sentiment_very_dissatisfied, size: 50.0)),
                  content: const Text(
                      'Aduh, Restoran yang kamu cari tidak ada. Cari restoran favoritmu lainnya'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              },
            )
          : showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Center(
                      child: Icon(CupertinoIcons.multiply_circle_fill,
                          size: 50.0)),
                  content: const Text(
                      'Aduh, Restoran yang kamu cari tidak ada. Cari restoran favoritmu lainnya'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
    }
  }
}
