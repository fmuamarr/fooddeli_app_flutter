import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:dicoding_food_deli/main.dart';
import 'package:dicoding_food_deli/src/data/api/api.dart';
import 'package:dicoding_food_deli/src/data/notification/notification_helper.dart';
import 'package:flutter/foundation.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().loadRestaurantList();

    //random index restaurant
    if (result.restaurants.isNotEmpty) {
      var randomIndex = Random().nextInt(result.restaurants.length);
      var randomRestaurant = result.restaurants[randomIndex];

      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, randomRestaurant);
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
