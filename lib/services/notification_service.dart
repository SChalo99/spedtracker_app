import 'dart:io';
import 'dart:math';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    //Request Permission Android
    if (Platform.isAndroid) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    const initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    _localNotificationsPlugin.initialize(initializationSettings).then((_) {
      debugPrint('Notification initialized');
    }).catchError((error) {
      debugPrint(error);
    });
  }

  void createNotification(String title, String body,
      {String sound = '',
      String channel = 'Canal',
      String channelId = '1'}) async {
    final androidDetail = AndroidNotificationDetails(channel, channel);
    const iosDetail = DarwinNotificationDetails();

    final notificationDetails = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );

    Random random = Random();
    int randomNumber = random.nextInt(100);
    final id = randomNumber;

    await _localNotificationsPlugin.show(id, title, body, notificationDetails);
  }

  // Add or Schedule a Notification
  void addScheduleNotification(
    String title,
    String body,
    DateTime dateTime, {
    String sound = '',
    String channel = 'Canal',
  }) async {
    final androidDetail = AndroidNotificationDetails(channel, channel);

    const iosDetail = DarwinNotificationDetails();

    final noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );
    tz_data.initializeTimeZones();

    Random random = Random();
    int randomNumber = random.nextInt(100);
    final id = randomNumber;
    tz_data.initializeTimeZones();

    tz.TZDateTime scheduleTime = tz.TZDateTime.from(
      dateTime,
      tz.local,
    );

    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
