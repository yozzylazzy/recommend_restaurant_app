import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:rxdart/rxdart.dart';
import '../common/navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    try {
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('app_icon');
      var initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse:
              (NotificationResponse details) async {
        final payload = details.payload;
        if (payload != null) {
          log('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      });
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    try {
      var channelId = "1";
      var channelName = "channel_01";
      var channelDesc = "restaurant recommended channel";

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true),
      );

      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );
      var titleNotification = restaurant.name;
      var titleDesc =
          'Check this ${restaurant.rating} star restaurant in ${restaurant.city}';

      await flutterLocalNotificationsPlugin.show(
        0,
        titleNotification,
        titleDesc,
        platformChannelSpecifics,
        payload: json.encode(restaurant.toJsonSql()),
      );
    } catch (e) {
      log('Error $e');
    }
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      log('Received notification payload: $payload');
      Restaurant restaurant = Restaurant.fromJson(json.decode(payload));
      Navigation.intentWithData(route, restaurant);
    });
  }
}
