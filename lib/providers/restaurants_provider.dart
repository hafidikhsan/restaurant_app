import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/models/api/restaurants.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantsProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantsProvider({required this.apiServices}) {
    _fetchAllRestaurants();
  }

  late Restaurants _restaurantsResult;
  late ResultState _resultState;
  String _message = '';

  String get message => _message;

  Restaurants get result => _restaurantsResult;

  ResultState get state => _resultState;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurants = await apiServices.restaurantsList();
      if (restaurants.restaurants.isEmpty) {
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
