import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/api/restaurant.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/widgets/detail_list.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/providers/detail_provider.dart';

class DetailPage extends StatefulWidget {
  static var routeName = '/detail_restaurant';

  final Restaurant restaurants;

  const DetailPage({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsDetailProvider>(
      create: (_) => RestaurantsDetailProvider(
        restaurantId: widget.restaurants.id,
        apiServices: ApiServices(),
      ),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return const Scaffold(
      body: DetailList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
      ),
      child: DetailList(),
    );
  }
}
