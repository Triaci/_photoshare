import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:photoshare/routes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../models/shared_preferences.dart';

class LocalNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  LocalNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimeZone();
    await _initializeNotifications();
  }

  Future<void> _setupTimeZone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  _initializeNotifications() async {
    //o parâmetro passado é do ícone que aparecerá na notificação
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    await localNotificationsPlugin.initialize(
      const InitializationSettings(android: android),
      onSelectNotification: _onSelectNotification,
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!)
          .pushReplacementNamed(payload);
    }
  }

  //método que mostra a notificação e configura sua importância, prioridade e etc.
  showNotification(LocalNotification localnotification) {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_x',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.show(localnotification.id, localnotification.title,
        localnotification.body, NotificationDetails(android: androidDetails),
        payload: localnotification.payload);
  }

  scheduleNotification(LocalNotification localnotification) {
    Preferences preferences = Preferences();
    int seconds = preferences.getNotificationSeconds;

    final date = DateTime.now().add(Duration(seconds: seconds));
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_x',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    localNotificationsPlugin.zonedSchedule(
        localnotification.id,
        localnotification.title,
        localnotification.body,
        tz.TZDateTime.from(date, tz.local),
        NotificationDetails(android: androidDetails),
        payload: localnotification.payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
