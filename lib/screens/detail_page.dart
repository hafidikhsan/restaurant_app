import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class DetailPage extends StatelessWidget {
  static var routeName = '/detail_restaurant';

  final Restaurant restaurant;

  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
    );
  }
}
