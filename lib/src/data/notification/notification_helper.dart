// ignore_for_file: unused_import

import 'dart:convert';
import 'package:dicoding_food_deli/common/navigation.dart';
import 'package:dicoding_food_deli/model/restaurant_model.dart';
import 'package:dicoding_food_deli/provider/restaurant_provider.dart';
import 'package:dicoding_food_deli/src/screens/restaurant_item_screen/restaurant_item_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      if (payload != null) {
        if (kDebugMode) {
          print('notification payload: $payload');
        }
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "food deli resturant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Restaurant Recommendation</b>";
    var titleRecommend = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRecommend, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  Future<void> configureSelectNotificationSubject(
      BuildContext context, String route) async {
    selectNotificationSubject.stream.listen((String payload) async {
      final data = Restaurant.fromJson(json.decode(payload));
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .loadRestaurantDetail(data.id);
      Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
          arguments: data);
    });
  }
}
