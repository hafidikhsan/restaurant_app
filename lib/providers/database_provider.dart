import 'package:flutter/material.dart';
import 'package:restaurant_app/database/database_helper.dart';
import 'package:restaurant_app/models/api/restaurant.dart';
import 'package:restaurant_app/providers/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _resultState = ResultState.loading;
  ResultState get state => _resultState;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _resultState = ResultState.hasData;
    } else {
      _resultState = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteByUrl(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
