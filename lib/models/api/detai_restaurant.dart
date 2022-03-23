import 'dart:convert';
import 'package:restaurant_app/models/api/restaurant_detail.dart';

DetailRestaurant detailRestaurantFromJson(String str) =>
    DetailRestaurant.fromJson(
      json.decode(str),
    );

class DetailRestaurant {
  DetailRestaurant({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(
          json["restaurant"],
        ),
      );
}
