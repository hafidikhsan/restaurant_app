import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/database/database_helper.dart';
import 'package:restaurant_app/providers/database_provider.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurants_list.dart';

class ListPage extends StatefulWidget {
  static var routeName = '/restaurant_list';

  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantsProvider(
            apiServices: ApiServices(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return const Scaffold(
      body: RestaurantList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
      ),
      child: RestaurantList(),
    );
  }
}
