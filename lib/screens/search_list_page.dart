import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/search_provider.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/widgets/app_bar.dart';
import 'package:restaurant_app/widgets/search_card.dart';
import 'package:restaurant_app/providers/result_state.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  late TextEditingController _controller;
  String queryKey = '';

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
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(
        apiServices: ApiServices(),
        valueKey: queryKey,
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          const CustomAppBar(
            titlePage: 'Pencarian',
            floatingValue: false,
            centerTitleValue: false,
            pinnedValue: true,
          ),
          _textInput(context),
          (queryKey == '') ? const SliverToBoxAdapter() : _title(context),
          (queryKey == '')
              ? _find(context)
              : Consumer<SearchProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state.state == ResultState.hasData) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var restaurantsData =
                                state.result.restaurants[index];
                            return SearchCard(
                              restaurants: restaurantsData,
                            );
                          },
                          childCount: state.result.restaurants.length,
                        ),
                      );
                    } else if (state.state == ResultState.noData) {
                      return _error(
                        context,
                        "Aduh Restoran atau Menu favoritmu tidak ada",
                        Icons.sentiment_very_dissatisfied,
                      );
                    } else if (state.state == ResultState.error) {
                      return _error(
                        context,
                        "Maaf terjadi error dengan server",
                        Icons.sentiment_dissatisfied,
                      );
                    } else {
                      return _error(
                        context,
                        "Maaf terjadi error, refresh kembali halaman",
                        Icons.refresh,
                      );
                    }
                  },
                )
        ],
      ),
    );
  }

  Widget _error(BuildContext context, String s, IconData image) {
    var screenSize = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: screenSize.height * 0.6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                image,
                size: 100.0,
                color: const Color.fromARGB(255, 42, 66, 131),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  s,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<SearchProvider>(
          builder: (context, state, _) {
            return TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Restoran atau Menu favoritmu...',
              ),
              onSubmitted: (newValue) {
                state.queryKey = newValue;
                setState(
                  () {
                    queryKey = newValue;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _find(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: screenSize.height * 0.8,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.restaurant,
                size: 100.0,
                color: Color.fromARGB(255, 42, 66, 131),
              ),
              Text(
                "Makan apa kamu hari ini ?",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0,
        ),
        child: Text(
          "Hasil Pencarian",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
