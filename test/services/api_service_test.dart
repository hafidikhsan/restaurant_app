import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/api/find_restaurants.dart';
import 'package:restaurant_app/models/api/restaurants.dart';
import 'package:restaurant_app/services/api_service.dart';

void main() {
  test(
    "Fetch data from API return a Restaurants class",
    () {
      ApiServices().restaurantsList();

      expect(
        ApiServices().restaurantsList(),
        isA<Future<Restaurants>>(),
      );
    },
  );
  test(
    "Search data from API return a Restaurants class for search screen",
    () {
      var data = ApiServices().findList("bright");

      expect(
        data,
        isA<Future<FindRestaurant>>(),
      );
    },
  );
}
