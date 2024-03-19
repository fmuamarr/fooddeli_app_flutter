import 'dart:async';
import 'dart:io';

import 'package:dicoding_food_deli/model/restaurant_detail_model.dart';
import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/model/restaurant_search_model.dart';
import 'package:dicoding_food_deli/src/data/api/api.dart';
import 'package:flutter/foundation.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = "";

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  RestaurantDetailResult get detailResult => _restaurantDetailResult;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.loadRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'No Internet Connection. Try again once you connected to the Internet.';
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Request timed out. Please try again later.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _state;
  String _message = "";

  String get message => _message;
  RestaurantDetailResult get detailResult => _restaurantDetailResult;
  ResultState get state => _state;

  Future<void> loadRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.loadRestaurantDetail(id);
      if (restaurantDetail.message != 'success' ||
          restaurantDetail.error != false) {
        _state = ResultState.noData;
        if (restaurantDetail.message == 'not_found') {
          _message = 'Restaurant not found';
        } else {
          _message = 'Unknown error occurred';
        }
      } else {
        _state = ResultState.hasData;
        _restaurantDetailResult = restaurantDetail;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      _message =
          'No Internet Connection. Try again once you connected to the Internet.';
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      _message = 'Request timed out. Please try again later.';
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
    }
    notifyListeners();
  }
}

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResult _restaurantSearchResult;
  late ResultState _state = ResultState.noData;
  String _message = "";

  String get message => _message;
  RestaurantSearchResult get searchResult => _restaurantSearchResult;
  ResultState get state => _state;

  Future<void> loadRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.loadRestaurantSearch(query);
      if (restaurantSearch.founded == 0) {
        _state = ResultState.noData;
        _message = 'No restaurant founded.';
      } else {
        _state = ResultState.hasData;
        _restaurantSearchResult = restaurantSearch;
      }
    } on SocketException catch (_) {
      _state = ResultState.error;
      _message =
          'No Internet Connection. Try again once you connected to the Internet.';
    } on TimeoutException catch (_) {
      _state = ResultState.error;
      _message = 'Request timed out. Please try again later.';
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
    }
    notifyListeners();
  }
}
