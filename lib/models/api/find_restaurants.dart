import 'dart:convert';
import 'package:restaurant_app/models/api/restaurant.dart';

FindRestaurant findRestaurantFromJson(String str) => FindRestaurant.fromJson(
      json.decode(str),
    );

class FindRestaurant {
  FindRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory FindRestaurant.fromJson(Map<String, dynamic> json) => FindRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );
}
