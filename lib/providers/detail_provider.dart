import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/models/api/detai_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantsDetailProvider extends ChangeNotifier {
  final ApiServices apiServices;
  final String restaurantId;

  RestaurantsDetailProvider({
    required this.restaurantId,
    required this.apiServices,
  }) {
    _fetchRestaurant();
  }

  late DetailRestaurant _restaurantsResult;
  late ResultState _resultState;
  String _message = '';

  String get message => _message;

  DetailRestaurant get result => _restaurantsResult;

  ResultState get state => _resultState;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurants = await apiServices.detailRestaurantList(restaurantId);
      if (restaurants.restaurant.id.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurants;
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}
