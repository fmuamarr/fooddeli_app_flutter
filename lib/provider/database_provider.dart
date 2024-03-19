import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/data/db/database_helper.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'No favorite Data';
    }

    notifyListeners();
  }

  void addFavorites(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _state = ResultState.hasData;
      _getFavorites();
    } catch (e) {
      _state = ResultState.noData;
      _message = 'Error adding favorite';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
