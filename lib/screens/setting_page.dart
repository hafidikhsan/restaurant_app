import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class SettingPage extends StatefulWidget {
  static var routeName = '/setting_page';

  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Halo")),
    );
  }

  Widget _buildIos(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
      ),
      child: Center(child: Text("Halo")),
    );
  }
}
