import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const onboardPageKey = 'ONBOARD_PAGE';

  Future<bool> get isOnboardPageShowed async {
    final prefs = await sharedPreferences;
    return prefs.getBool(onboardPageKey) ?? false;
  }

  void setOnboardPage(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(onboardPageKey, value);
  }

  static const dailyRestaurantKey = 'DAILY_RESTAURANT';

  Future<bool> get isDailyRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurantKey) ?? false;
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurantKey, value);
  }
}
