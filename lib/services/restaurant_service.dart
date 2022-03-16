import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:restaurant_app/models/restaurant.dart';
import '../models/restaurants.dart';

Future<String> _loadRestaurantAssets() async {
  return await rootBundle.loadString('assets/local_restaurant.json');
}

Future<List<Restaurant>> loadProduct() async {
  String jsonString = await _loadRestaurantAssets();
  final restaurants = restaurantsFromJson(jsonString);
  List<Restaurant> data = restaurants.restaurants;

  return data;
}
