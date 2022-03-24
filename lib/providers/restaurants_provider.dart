import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/models/api/restaurants.dart';
import 'package:restaurant_app/providers/resutl_state.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantsProvider({required this.apiServices}) {
    _fetchAllRestaurants();
  }

  late Restaurants _restaurantsResult;
  late ResultState _resultState;
  String _message = '';
  bool _short = false;

  String get message => _message;

  bool get short => _short;

  Restaurants get result => _restaurantsResult;

  ResultState get state => _resultState;

  set short(bool value) {
    _short = value;
    notifyListeners();
    _fetchAllRestaurants();
  }

  Color get color =>
      (_short) ? Colors.white : const Color.fromARGB(255, 42, 66, 131);

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
