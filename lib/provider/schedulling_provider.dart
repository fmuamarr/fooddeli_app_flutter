import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_food_deli/src/data/notification/background_service.dart';
import 'package:dicoding_food_deli/src/data/notification/date_time_helper.dart';
import 'package:flutter/foundation.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRecommendation(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      if (kDebugMode) {
        print('Scheduling Recommendation Activated');
      }
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling Recommendation Canceled');
      }
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
