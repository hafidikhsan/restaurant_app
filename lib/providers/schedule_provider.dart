import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:restaurant_app/services/background_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingProvider() {
    _loadNumber();
  }
  bool _isScheduled = false;

  static const String togglePrefs = 'scheduling';

  bool get isScheduled => _isScheduled;

  set isScheduled(bool value) {
    _isScheduled = value;
    notifyListeners();
    scheduledRestaurants(_isScheduled);
    _saveToggle();
  }

  void _saveToggle() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool(togglePrefs, _isScheduled);
  }

  void _loadNumber() async {
    final prefs = await SharedPreferences.getInstance();

    _isScheduled = prefs.getBool(togglePrefs) ?? false;
    notifyListeners();
    scheduledRestaurants(_isScheduled);
  }

  Future<bool> scheduledRestaurants(bool value) async {
    if (_isScheduled) {
      print('Yey, Scheduling Activated');
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
      print('Ops, Scheduling Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
