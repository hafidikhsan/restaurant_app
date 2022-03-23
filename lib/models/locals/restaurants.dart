import 'dart:convert';
import 'restaurant.dart';

Restaurants restaurantsFromJson(String str) =>
    Restaurants.fromJson(json.decode(str));

class Restaurants {
  Restaurants({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
