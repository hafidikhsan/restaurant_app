import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/widgets/detail_list.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailPage extends StatefulWidget {
  static var routeName = '/detail_restaurant';

  final Restaurant restaurants;

  const DetailPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        body: DetailList(
      restaurant: widget.restaurants,
    ));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: DetailList(
        restaurant: widget.restaurants,
      ),
    );
  }
}
