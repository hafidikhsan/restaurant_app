import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/api/find_restaurants.dart';
import 'package:restaurant_app/models/api/restaurants.dart';
import 'package:restaurant_app/models/api/detai_restaurant.dart';

class ApiServices {
  final http.Client client;

  ApiServices({required this.client});

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _list = 'list';
  static const String _detail = 'detail/';
  static const String _find = 'search?q=';

  Future<Restaurants> restaurantsList() async {
    final response = await client.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      final restaurants = restaurantsFromJson(response.body);
      return restaurants;
    } else {
      throw Exception('Failed to load Restaurant');
    }
  }

  Future<FindRestaurant> findList(String value) async {
    final response = await client.get(Uri.parse(_baseUrl + _find + value));
    if (response.statusCode == 200) {
      final restaurants = findRestaurantFromJson(response.body);
      return restaurants;
    } else {
      throw Exception('Failed to load Restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurantList(String restaurantId) async {
    final response =
        await client.get(Uri.parse(_baseUrl + _detail + restaurantId));
    if (response.statusCode == 200) {
      final restaurants = detailRestaurantFromJson(response.body);
      return restaurants;
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }
}
