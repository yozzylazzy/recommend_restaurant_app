import 'dart:developer';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import '../utils/background_service.dart';
import '../utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isNotified = false;

  bool get isNotified => _isNotified;

  Future<bool> scheduleReminder(bool value) async {
    _isNotified = value;
    if (_isNotified) {
      log('Restaurant Recommendation Notifier Turned On');
      notifyListeners();
      // DateTime nextMinute = DateTime.now().add(const Duration(minutes: 1)); --> Tester
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      log('Restaurant Recommendation Notifier Turned Off');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
