import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/models/api/find_restaurants.dart';
import 'package:restaurant_app/providers/result_state.dart';

class SearchProvider extends ChangeNotifier {
  final ApiServices apiServices;
  String valueKey;

  SearchProvider({
    required this.apiServices,
    required this.valueKey,
  }) {
    _fetchRestaurant();
  }

  late FindRestaurant _restaurantsResult;
  late ResultState _resultState;
  String _message = '';
  String _queryKey = '';

  String get queryKey => _queryKey;

  String get message => _message;

  FindRestaurant get result => _restaurantsResult;

  ResultState get state => _resultState;

  set queryKey(String value) {
    _queryKey = value;
    notifyListeners();
    _fetchRestaurant();
  }

  Future<dynamic> _fetchRestaurant() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final restaurants = await apiServices.findList(_queryKey);
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
