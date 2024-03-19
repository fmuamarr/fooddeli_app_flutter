import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_food_deli/model/restaurant_detail_model.dart';
import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/provider/database_provider.dart';
import 'package:dicoding_food_deli/provider/preferences_provider.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/constants/themes.dart';
import 'package:dicoding_food_deli/src/data/api/api.dart';
import 'package:dicoding_food_deli/src/data/db/database_helper.dart';
import 'package:dicoding_food_deli/src/data/notification/background_service.dart';
import 'package:dicoding_food_deli/src/data/notification/notification_helper.dart';
import 'package:dicoding_food_deli/provider/schedulling_provider.dart';
import 'package:dicoding_food_deli/src/data/preferences/preferences_helper.dart';
import 'package:dicoding_food_deli/src/screens/login_screen/login_screen.dart';
import 'package:dicoding_food_deli/src/screens/main_screen/home_screen.dart';
import 'package:dicoding_food_deli/src/screens/navbar_screen/bottom_navbar.dart';
import 'package:dicoding_food_deli/src/screens/onboarding_screen/onboarding_screen.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_item_detail.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_list_screen.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_search_screen.dart';
import 'package:dicoding_food_deli/src/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<RestaurantProvider>(
        create: (context) => RestaurantProvider(apiService: ApiService()),
      ),
      ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(apiService: ApiService()),
      ),
      ChangeNotifierProvider(
        create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      ),
      ChangeNotifierProvider(
        create: (_) => PreferencesProvider(
          preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
      ),
      ChangeNotifierProvider(
        create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      ),
      ChangeNotifierProvider(create: (_) => SchedulingProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesProvider = Provider.of<PreferencesProvider>(context);
    final showOnboard = preferencesProvider.isOnboardPageShowed;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Deli',
      theme: myTheme,
      initialRoute:
          showOnboard ? OnBoardingScreen.routeName : LoginScreen.routeName,
      routes: {
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        BottomNavbar.routeName: (context) => const BottomNavbar(),
        RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
            restaurant:
                ModalRoute.of(context)!.settings.arguments as Restaurant),
        RestaurantListScreen.routeName: (context) =>
            const RestaurantListScreen(),
        HomePageScreen.routeName: (context) => const HomePageScreen(),
        ReviewScreen.routeName: (context) => ReviewScreen(
            reviews: ModalRoute.of(context)!.settings.arguments
                as List<CustomerReview>),
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}
