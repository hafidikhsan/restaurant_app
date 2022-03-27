import 'dart:isolate';
import 'dart:ui';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

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
    print('New Notification!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiServices().restaurantsList();
    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Updated data from the background isolate');
  }
}
