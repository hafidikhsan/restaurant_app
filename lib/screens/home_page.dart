import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/bottom_navigation.dart';
import 'package:restaurant_app/screens/search_page.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/screens/list_page.dart';

class HomePage extends StatefulWidget {
  static var routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _homeTitle = 'Home';

  final List<Widget> _listWidget = [
    ChangeNotifierProvider(
      create: (_) => RestaurantsProvider(
        apiServices: ApiServices(),
      ),
      child: const ListPage(),
    ),
    const SearchPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home_filled),
      label: _homeTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
      label: "Pencarian",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      create: (BuildContext context) => BottomNavigationBarProvider(),
      child: Consumer<BottomNavigationBarProvider>(
        builder: (contex, bottomNavigation, _) => Scaffold(
          body: _listWidget[bottomNavigation.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavigation.currentIndex,
            items: _bottomNavBarItems,
            onTap: (newValue) {
              bottomNavigation.currentIndex = newValue;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }
}
