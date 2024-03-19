import 'dart:convert';

import 'package:dicoding_food_deli/model/restaurant_detail_model.dart';
import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/model/restaurant_search_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  http.Client? httpClient;
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _listUrl = '/list';
  static const String _detailUrl = '/detail';
  static const String _searchUrl = '/search?q=';

  ApiService({this.httpClient});

  Future<RestaurantResult> loadRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + _listUrl));

    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResult> loadRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl$_detailUrl/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResult> loadRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + _searchUrl + query));

    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
