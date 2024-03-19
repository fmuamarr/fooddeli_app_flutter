import 'package:dicoding_food_deli/src/data/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getOnboardPage();
    _getDailyRestaurantPreferences();
  }

  bool _isOnboardPageShowed = false;
  bool get isOnboardPageShowed => _isOnboardPageShowed;

  bool _isDailyRecommendationActive = false;
  bool get isDailyRecommendationActive => _isDailyRecommendationActive;

  void _getOnboardPage() async {
    _isOnboardPageShowed = await preferencesHelper.isOnboardPageShowed;
    notifyListeners();
  }

  void _getDailyRestaurantPreferences() async {
    _isDailyRecommendationActive =
        await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void isOnboardDone() {
    preferencesHelper.setDailyRestaurant(true);
    _getOnboardPage();
  }

  void enableDailyRecommendation(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
  }
}
