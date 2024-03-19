import 'package:dicoding_food_deli/model/restaurant_model.dart';

class RestaurantSearchResult {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestaurantSearchResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
