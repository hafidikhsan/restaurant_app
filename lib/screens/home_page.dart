import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/bottom_navigation.dart';
import 'package:restaurant_app/providers/schedule_provider.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/screens/favorite_page.dart';
import 'package:restaurant_app/screens/search_page.dart';
import 'package:restaurant_app/screens/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/screens/list_page.dart';

class HomePage extends StatefulWidget {
  static var routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _homeTitle = 'Beranda';
  static const String _searchTitle = 'Pencarian';
  static const String _favoriteTitle = 'Favorite';
  static const String _settingTitle = 'Pengaturan';

  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      DetailPage.routeName,
    );
    SchedulingProvider();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  final List<Widget> _listWidget = [
    const ListPage(),
    const SearchPage(),
    const FavoritePage(),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: const SettingPage(),
    ),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.home : Icons.home_filled,
      ),
      label: _homeTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.search : Icons.search,
      ),
      label: _searchTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.heart_fill : Icons.favorite,
      ),
      label: _favoriteTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
      ),
      label: _settingTitle,
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
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12.0,
            iconSize: 25.0,
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
